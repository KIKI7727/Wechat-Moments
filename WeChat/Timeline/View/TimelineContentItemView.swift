//
//  TimelineContentItemView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/26.
//

import SwiftUI

enum Contants {
    static let imageSize: CGSize = .init(width: 50, height: 50)
    static let nickSpacing: CGFloat = 10
    static let singlePhotoMaxWidth: CGFloat = 200
    
}

struct TimelineContentItemView: View {
    @State var isShow: Bool = false
    @State var isLikeArrayShow: Bool = false
    @State var commentText: String = ""
    @State var isCommentShow = false
    
    
    var moment: Moment
    init(_ moment: Moment) {
        self.moment = moment
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                ZStack {
                    if let sender = moment.sender {
                        AsyncImage(url: URL(string: sender.avatar)) { image in
                            if let image = image {
                                image
                                    .resizable()
                                    .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)
                            }
                        } placeholder: {
                            Color.gray
                                .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)
                        }
                    } else {
                        Color.gray
                        .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)                }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    if let nick = moment.sender?.nick {
                        Text(nick)
                            .bold()
                    }
                    if let cont = moment.content {
                        Text(cont)
                            .fontWeight(.light)
                            .padding(.vertical, 2)
                    }
                    
                    if let images = moment.images{
                        Group {
                            if images.count == 4 {
                                
                                let columns = [
                                    GridItem(.fixed(80), spacing: 2),
                                    GridItem(.fixed(80), spacing: 2)
                                ]
                                LazyVGrid(columns: columns, alignment: .leading, spacing: 2) {
                                    ForEach(Array(images.enumerated()), id: \.offset) { index, element in
                                        imageView(element.url)
                                    }
                                }.padding(.vertical)
                            } else {
                                
                                let columns = [
                                    GridItem(.fixed(80), spacing: 2),
                                    GridItem(.fixed(80), spacing: 2),
                                    GridItem(.fixed(80), spacing: 2),
                                ]
                                
                                LazyVGrid(columns: columns,alignment: .leading, spacing: 2) {
                                    ForEach(Array(images.enumerated()), id: \.offset) { index, element in
                                        imageView(element.url)
                                    }
                                }.padding(.vertical)
                            }
                        }
                    }
                }
                
            }
            
            HStack {
                if isLikeArrayShow == true {
                    HStack {
                        Image(systemName: "heart")
                        Text("Huan Huan").lineLimit(1)
                        Spacer()
                    }.background(.gray).padding(.leading,50)
                }
                
                Spacer()
                
                if isShow == true{
                    HStack{
                        Button(action: {
                            self.isShow = false
                            self.isLikeArrayShow = !self.isLikeArrayShow
                        }, label: {
                            HStack{
                                Image(systemName: "heart").resizable().frame(width: 20,height: 20).foregroundColor(.white)
                                Text("点赞").foregroundColor(Color.white).lineLimit(1).fixedSize()
                            }
                        })
                        .buttonStyle(BorderlessButtonStyle())
                        Text("|")
                        Button(action: {
                            self.isShow = false
                            self.isCommentShow = !self.isCommentShow
                        }, label: {
                            HStack{
                                Image(systemName: "bubble.left").resizable().frame(width: 20,height: 20).foregroundColor(.white)
                                Text("评论").foregroundColor(Color.white).lineLimit(1).fixedSize()
                            }
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .circular).foregroundColor(.gray)
                    )
                }
                Button(action: {
                    self.isShow = !self.isShow
                }, label: {
                    Image("comment")
                })
                .buttonStyle(BorderlessButtonStyle())
            }
            if isCommentShow == true {
                TextField("评论...", text: $commentText)
            }
        }
    }
}



extension TimelineContentItemView {
    func imageView(_ url: String) -> some View {
        AsyncImage(
            url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    Text("")
                case .success(let image):
                    image.resizable()
                    //  .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                @unknown default:
                    EmptyView()
                }
            }
    }
    
    func showLineImage(_ imageArray: [String]) -> some View {
        HStack(spacing: 0) {
            ForEach(imageArray, id: \.self) { image in
                imageView(image)
            }
        }
    }
}

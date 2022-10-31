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
    @StateObject var vm: TimelineContentItemViewModel
    @State var isShow: Bool = false
    
    init(_ moment: Moment) {
        _vm = StateObject(wrappedValue: TimelineContentItemViewModel(moment))
    }
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: vm.moment.sender?.avatar ?? ""), content: { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)
                } else {
                    ProgressView()
                }
            })
            
            VStack(alignment: .leading, spacing: 0) {
                if let nick = vm.moment.sender?.nick {
                    Text(nick)
                        .bold()
                }
                if let cont = vm.moment.content {
                    Text(cont)
                        .fontWeight(.light)
                }
                if let images = vm.moment.images{
                    Group {
                        if images.count == 4 {
                            let columns = [GridItem(.flexible(minimum: 80)), GridItem(.flexible(minimum: 80))]
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(Array(images.enumerated()), id: \.offset) { index, element in
                                    imageView(element.url)
                                }
                            }
                        } else {
                            let columns = [GridItem(spacing: 15), GridItem(spacing: 15), GridItem(spacing: 15)]
                            LazyVGrid(columns: columns,alignment: .leading, spacing: 10) {
                                ForEach(Array(images.enumerated()), id: \.offset) { index, element in
                                    imageView(element.url)
                                }
                            }
                        }
                    }
                }
            }
            
        }
        HStack {
            Spacer()
            if isShow == true{
                HStack{
                    Button(action: {
                        self.isShow = false
                    }, label: {
                        HStack{
                            Image(systemName: "heart").resizable().frame(width: 20,height: 20).foregroundColor(.white)
                            Text("点赞").foregroundColor(Color.white)
                        }
                    })
                    .buttonStyle(BorderlessButtonStyle())
                    Text("|")
                    Button(action: {
                        self.isShow = false
                    }, label: {
                        HStack{
                            Image(systemName: "bubble.left").resizable().frame(width: 20,height: 20).foregroundColor(.white)
                            Text("评论").foregroundColor(Color.white)
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
    }
}


extension TimelineContentItemView {
    func imageView(_ url: String) -> some View {
        AsyncImage(
            url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)
                case .success(let image):
                    image.resizable()
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
  //过滤错误数据
    func showLineImage(_ imageArray: [String]) -> some View {
        HStack(spacing: 0) {
            ForEach(imageArray, id: \.self) { image in
                imageView(image)
            }
        }
    }
}

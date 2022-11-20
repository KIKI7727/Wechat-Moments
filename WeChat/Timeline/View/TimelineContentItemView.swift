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
  @State var isShow: Bool
  @State var isLikeArrayShow: Bool = false
  @State var allComments: [Comments] = []
  @StateObject private var profileHeaderViewModel: ProfileHeaderViewModel = .init()
  @StateObject private var timelineContentViewModel: TimelineContentViewModel = TimelineContentViewModel()
  var moment: Moment
  //self.allcoments = self.moment.comments
  var body: some View {
    VStack(alignment: .leading) {
      HStack(alignment: .top) {

        if let sender = moment.sender {
          /*  AsyncImage(url: URL(string: sender.avatar)) { image in
           if let image = image {
           image
           .resizable()
           .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)
           }
           } placeholder: {
           Color.gray
           .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)
           }*/
          if let avatar = sender.avatar {
            UrlImageView(urlString: avatar)
              .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)
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
              } else if images.count == 1 {
                Spacer()
                UrlImageView(urlString: images[0].url)
                  .frame(width: 200, height: 170)
                //                  }.padding(.vertical)
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
    }

      if isLikeArrayShow == true {
        HStack {
          Image(systemName: "heart")
          Text("Huan Huan").lineLimit(1)
          Spacer()
        }.background(.gray).padding(.leading,50)
      }
      //Spacer()

      HStack {
        Spacer()
        Button(action: {
          self.isShow = !self.isShow

        }, label: {
          Image("comment")
        })
        .buttonStyle(BorderlessButtonStyle())
        .fullScreenCover(isPresented: $isShow) {
          InputDialogView(isPresented: $isShow, isLike: $isLikeArrayShow, action: { item in
            if (!item.isEmpty){
              let newComment = Comments(content: item, sender: (Sender(username: profileHeaderViewModel.userName, nick:profileHeaderViewModel.nickName, avatar: profileHeaderViewModel.avatar)))
              self.allComments.append(newComment)
            }
          })
          .background(BackgroundCleanerView())

        }
      }

      if let comments = self.moment.comments{
        ForEach(Array(((comments.enumerated()))), id:\.offset){ index, Comment in//大小写
          Text("\(Comment.sender.nick): \(Comment.content)")
        }.padding(.leading,50)
      }
      if !self.allComments.isEmpty{
        ForEach(Array(((self.allComments.enumerated()))), id:\.offset){ index, Comment in//大小写
          Text("\(Comment.sender.nick): \(Comment.content)")
        }.padding(.leading,50)
      }

      Divider()
    }
  }



struct BackgroundCleanerView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }

  func updateUIView(_ uiView: UIView, context: Context) {}
}

extension TimelineContentItemView {
  func imageView(_ url: String) -> some View {
    /*  AsyncImage(
     url: URL(string: url)) { phase in
     switch phase {
     case .empty:
     Text("")
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
     }*/
    UrlImageView(urlString: url)
      .frame(width: 80, height: 80)
  }


  func showLineImage(_ imageArray: [String]) -> some View {
    HStack(spacing: 0) {
      ForEach(imageArray, id: \.self) { image in
        imageView(image)
      }
    }
  }
}


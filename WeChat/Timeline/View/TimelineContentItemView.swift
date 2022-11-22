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
          if let avatar = sender.avatar {
            UrlImageView(urlString: avatar)
              .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)
          } else {
            Color.gray
              .frame(width: Contants.imageSize.width, height: Contants.imageSize.height)
          }
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
            gridView(images)
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
      ForEach(Array(((comments.enumerated()))), id:\.offset){ index, comment in
        Text("\(comment.sender.nick): \(comment.content)")
      }.padding(.leading,50)
    }
    if !self.allComments.isEmpty{
      ForEach(Array(((self.allComments.enumerated()))), id:\.offset){ index, comment in
        Text("\(comment.sender.nick): \(comment.content)")
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

  @ViewBuilder
  func gridView(_ images: [Images] ) -> some View {

    let columns: [GridItem] = (images.count == 4 ?
                               [ GridItem(.fixed(80), spacing: 2),GridItem(.fixed(80), spacing: 2)] :
                               [ GridItem(.fixed(80), spacing: 2),GridItem(.fixed(80), spacing: 2),GridItem(.fixed(80), spacing: 2)])

    if images.count == 1 {
      Spacer()
      UrlImageView(urlString: images[0].url)
        .frame(width: 200, height: 170)
    } else {
      LazyVGrid(columns: columns, alignment: .leading, spacing: 2) {
        ForEach(Array(images.enumerated()), id: \.offset) { index, element in
          imageView(element.url)
        }
      }.padding(.vertical)
    }
  }

  func imageView(_ url: String) -> some View {
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


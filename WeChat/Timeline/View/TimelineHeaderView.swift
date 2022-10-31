//
//  TimelineHeaderView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/25.
//

import SwiftUI

struct TimelineHeaderView: View {
    private enum Contants {
        static let profileImageSize: CGSize = .init(width: 70, height: 70)
        static let nickAndProfileOffsetX: CGFloat = -15
        static let nickAndProfileOffsetY: CGFloat = 10
        static let contentBottomPadding: CGFloat = 20
    }
    
    let nickname: String
    let profileImageName: String
    let backgroundImageName: String
    
    @StateObject private var profileHeaderViewModel: ProfileHeaderViewModel = .init()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: URL(string: profileHeaderViewModel.profileHeaderUrl),content:{ pahse in
                if let image = pahse.image {
                    image
                        .resizable()
                        .scaledToFit()
                }
            })
            .frame(width: UIScreen.main.bounds.width)
            .aspectRatio(contentMode: .fit)
            .padding(.bottom)
            
            HStack {
                Text(profileHeaderViewModel.nickName)
                    .foregroundColor(.white)
                    .bold()
                AsyncImage(url: URL(string: profileHeaderViewModel.avatar),content:{ pahse in
                    if let image = pahse.image {
                        image
                            .resizable()
                    }
                })
                .frame(width: Contants.profileImageSize.width,
                       height: Contants.profileImageSize.height)
            }
            .offset(x: Contants.nickAndProfileOffsetX, y: Contants.nickAndProfileOffsetY)
        }
        .padding(.bottom, Contants.contentBottomPadding)
    }
}

struct TimelineHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineHeaderView(nickname: "", profileImageName: "images", backgroundImageName: "background")
    }
}

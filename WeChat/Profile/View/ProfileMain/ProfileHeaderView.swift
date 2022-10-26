//
//  ProfileHeaderView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/24.
//

import SwiftUI
import Foundation

struct ProfileHeaderView: View {
    @StateObject var ProfileHeaderViewModel: ProfileHeaderViewModel = .init()
    
    var body: some View {
        VStack() {
            HStack {
                AsyncImage(url: URL(string: ProfileHeaderViewModel.avatar),content:{ pahse in
                    if let image = pahse.image {
                        image
                            .resizable()
                    }
                })
                    .frame(width: 70,height: 70)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    Text(ProfileHeaderViewModel.nickName)
                        .lineLimit(2)
                        .font(.title)
                        .foregroundColor(.black)
                    HStack {
                        Text(ProfileHeaderViewModel.userName)
                            .lineLimit(1)
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView()
    }
}

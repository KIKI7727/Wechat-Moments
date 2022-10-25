//
//  ProfileHeaderView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/24.
//

import SwiftUI
import Foundation

struct ProfileHeaderView: View {
    var body: some View {
        VStack() {
            HStack {
                Image("images")
                    .resizable()
                    .frame(width: 70,height: 70)
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading) {
                    Text("SleepRabbit")
                        .lineLimit(2)
                        .font(.title)
                        .foregroundColor(.black)
                    HStack {
                        Text("微信号:weixinhao")
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

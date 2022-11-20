//
//  ProfileView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/10/24.
//

import SwiftUI

struct ProfileView: View {
  
  var body: some View {
    List{
      Section{
        ProfileHeaderView()
      }
      Section{
        HStack{
          Image(systemName: "message.and.waveform")
          Text("服务")
        }
        HStack{
          Image(systemName: "shippingbox")
          Text("收藏")
        }
        HStack{
          Image(systemName: "menucard")
          Text("卡包")
        }
        HStack{
          Image(systemName: "gearshape")
          Text("设置")
        }
      }
    }
  }
  
}
struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

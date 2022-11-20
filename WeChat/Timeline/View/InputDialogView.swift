//
//  InputDialogView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/11/7.
//

import SwiftUI

struct InputDialogView: View {
  
  @Binding var isPresented:Bool
  
  @State var commentText: String = ""
  
  @Binding var isLike: Bool 
  
  
  var action: (_ :String)->Void
  
  var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(.gray.opacity(0.4))
        .ignoresSafeArea()
      VStack {
        Spacer()
        VStack(spacing: 15) {
          Text("评论")
            .font(.title2)
            .fontWeight(.bold)
            .padding(20)
          TextField("请在这里评论...", text: $commentText)
            .padding(.vertical)
            .padding(.horizontal, 24)
            .overlay(Capsule().stroke(.blue.opacity(0.5),lineWidth: 2))
          
          Divider()
          HStack(alignment: .center) {
            Spacer()
            Button(action: {
              self.isPresented = false
              self.isLike.toggle()
              print("+++")
            }, label: {
              HStack{
                Text("点赞")
              }
            })
            
            Button(action: {
              self.isPresented = false
              action(commentText)
            }, label: {
              HStack{
                Text("评论")
              }
            })
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).foregroundColor(.white))
          }
        }
        .cornerRadius(25)
        .background(.white)
        
      }
    }
  }
}


//
//  LoadingIndicator.swift
//  WeChat
//
//  Created by cai dongyu on 2022/11/3.
//

import SwiftUI

struct LoadingIndicator: View {
  
  var style: LoadingState
  
  var body: some View {
    HStack(spacing: 5.0) {
      Spacer()
      if style == .LoadMore {
        ProgressView()
        Text("Loading...")
          .foregroundColor(.gray)
      } 
      Spacer()
    }
    .padding()
    .background(Color.clear)
  }
}

struct LoadingIndicator_Previews: PreviewProvider {
  static var previews: some View {
    LoadingIndicator(style: .Loading)
    LoadingIndicator(style: .LoadComplete)
  }
}


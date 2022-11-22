//
//  UrlImageView.swift
//  WeChat
//
//  Created by cai dongyu on 2022/11/10.
//

import SwiftUI

struct UrlImageView: View {
  @ObservedObject var urlImageViewModel: UrlImageViewModel

  init(urlString: String) {
    urlImageViewModel = UrlImageViewModel(urlString: urlString)
  }

  var body: some View {
    if let image = urlImageViewModel.image {
      Image(uiImage: image)
        .resizable()
    } else {
      Image("gray")
        .resizable()
    }
  }
}

struct UrlImageView_Previews: PreviewProvider {
  static var previews: some View {
    UrlImageView(urlString: "")
  }
}

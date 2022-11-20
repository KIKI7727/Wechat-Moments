//
//  UrlImageViewModel.swift
//  WeChat
//
//  Created by cai dongyu on 2022/11/10.
//

import SwiftUI
import Foundation
import Combine

class UrlImageViewModel: ObservableObject {
  @Published var image: UIImage?
  var urlString: String?//改？
  var imageCache = ImageCache.sharedImageCache()

  var cancellables = Set<AnyCancellable>()

  init(urlString: String?) {
    self.urlString = urlString
    loadImage()
  }

  func loadImage() {
    guard let urlString = urlString else {
      return
    }

    if let cacheImage = imageCache.get(forKey: urlString){ //从缓存拿数据
      image = cacheImage
    } else {
      loadImageFromUrl()
    }
  }


  func loadImageFromUrl() {
    guard let urlString = urlString,
          let url = URL(string: urlString) else {
      return
    }
    
    URLSession.shared.dataTaskPublisher(for: url)
      .map { $0.data }
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        print(completion)
      }, receiveValue: { [weak self] data in
        self?.image = UIImage(data: data)
        self?.imageCache.set(forKey: urlString, image: (self?.image)!)//往缓存写数据
      })
      .store(in: &cancellables)
  }
}

class ImageCache {
  var cache = NSCache<NSString, UIImage>()

  func get(forKey: String) -> UIImage? {
    return cache.object(forKey: NSString(string: forKey))
  }

  func set(forKey: String, image: UIImage) {
    cache.setObject(image, forKey: NSString(string: forKey))
  }
}

extension ImageCache {
  private static var imageCache = ImageCache()
  static func sharedImageCache() -> ImageCache {
    return imageCache
  }
}


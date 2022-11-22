//
//  UrlImageViewModel.swift
//  WeChat
//
//  Created by cai dongyu on 2022/11/10.
//

import SwiftUI
import Foundation
import Combine

class CachedImage: NSObject, NSCoding {

  let image: UIImage
  let urlString: String
  init(image: UIImage, urlString: String) {
    self.image = image
    self.urlString = urlString
  }

  required init?(coder: NSCoder) {
    image = coder.decodeObject(forKey: "image") as! UIImage
    urlString = coder.decodeObject(forKey: "urlString") as! String
  }

  func encode(with coder: NSCoder) {
    coder.encode(image, forKey: "image")
    coder.encode(urlString, forKey: "urlString")
  }
}

class UrlImageViewModel: ObservableObject {
  @Published var image: UIImage?
  var urlString: String
  var imageCache = ImageCache.getImageCache()

  static var caches: [CachedImage] = []

  var cancellables = Set<AnyCancellable>()

  private static var cachedURL: URL {
    let path = NSHomeDirectory() + "/image.data"
    return URL(fileURLWithPath: path)
  }


  init(urlString: String) {
    self.urlString = urlString
    loadImage()
  }
  
  func loadImage() {
    if let cacheImage = imageCache.get(forKey: urlString) {
      self.image = cacheImage
      return
    }

    DispatchQueue.global().async {
      if let data = try? Data(contentsOf: UrlImageViewModel.cachedURL, options: []),
         let caches = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [CachedImage] {
        UrlImageViewModel.caches = caches

        if caches.contains(where: { $0.urlString == self.urlString}) {
          for cache in caches {
            if cache.urlString == self.urlString {
              print("===Load from Disk Cache ====")
              print(cache.urlString)

              DispatchQueue.main.async {
                self.image = cache.image
              }
              break
            }
          }
        } else {
          self.loadImageFromUrl()
        }
      }
      else {
        print("Cache miss, loading from url")
        self.loadImageFromUrl()
      }
    }
  }

  func storeImageinDisk(urlString: String, image: UIImage) {
    let cached = CachedImage(image: image, urlString: urlString)

    DispatchQueue.global().async {
      do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: UrlImageViewModel.caches + [cached] , requiringSecureCoding: false)
        try data.write(to: UrlImageViewModel.cachedURL)
        DispatchQueue.main.async {
          UrlImageViewModel.caches.append(cached)
        }
      } catch {

      }
    }
  }

  func loadImageFromUrl() {
    if let url = URL(string: urlString){
      URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
        }, receiveValue: { [weak self] data in

          if let image = UIImage(data: data) {
            // Disk Cache Store
            self?.storeImageinDisk(urlString: self!.urlString, image: image)
            // Memory Cache Store
            self?.imageCache.set(forKey: self!.urlString, image: image)
            self?.image = image
          }
        })
        .store(in: &cancellables)
    }
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
  static func getImageCache() -> ImageCache {
    return imageCache
  }
}

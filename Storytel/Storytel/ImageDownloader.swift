//
//  ImageDownloader.swift
//  Location
//
//  Created by Ajay Rawat on 2021-03-18.
//
/*!
 @discussion Download image from the server and store in local cache, cache limit is 100 item
 */

import Foundation
import UIKit

final class ImageDownloader {
  // MARK: Lifecycle

  init() {
    cache = NSCache()
    cache.countLimit = 100
  }

  // MARK: Internal

  var task: URLSessionDownloadTask?
  var cache: NSCache<NSString, UIImage>!

  func obtainImageWithPath(imagePath: String, completionHandler: @escaping (UIImage) -> ()) {
    if let image = cache.object(forKey: imagePath as NSString) {
      completionHandler(image)
    } else {
      let url: URL! = URL(string: imagePath)
      task = URLSession.shared.downloadTask(with: url, completionHandler: { _, _, _ in
        if let data = try? Data(contentsOf: url) {
          let img: UIImage! = UIImage(data: data)
          self.cache.setObject(img, forKey: imagePath as NSString)
          completionHandler(img)
        }
      })
      task?.resume()
    }
  }
}

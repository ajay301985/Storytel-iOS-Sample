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
      if let url = URL(string: imagePath) {
        task = URLSession.shared.downloadTask(with: url, completionHandler: { tempUrl, _, error in
          if error != nil {
            print(error!.localizedDescription)
            return
          }

          if let imageTempUrl = tempUrl {
            do {
              let imageData = try Data(contentsOf: imageTempUrl)
              if let imageObj = UIImage(data: imageData) {
                self.cache.setObject(imageObj, forKey: imagePath as NSString)
                completionHandler(imageObj)
              }
            } catch {
              print(error.localizedDescription)
            }
          }
        })
        task?.resume()
      } else {
        assertionFailure("Invalid Image Path \(imagePath)")
      }
    }
  }
}

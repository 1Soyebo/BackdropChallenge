//
//  ImageLoader.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import UIKit

class ImageLoader {
    
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
        
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

      // 1
      if let image = loadedImages[url] {
        completion(.success(image))
        return nil
      }

      // 2
      let uuid = UUID()

      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // 3
        defer {self.runningRequests.removeValue(forKey: uuid) }

        // 4
        if let data = data, let image = UIImage(data: data) {
          self.loadedImages[url] = image
          completion(.success(image))
          return
        }

        // 5
        guard let error = error else {return}

        guard (error as NSError).code == NSURLErrorCancelled else {
          completion(.failure(error))
          return
        }

        // the request was cancelled, no need to call the callback
      }
      task.resume()

      // 6
      runningRequests[uuid] = task
      return uuid
    }
    
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}


class UIImageLoader {
  static let loader = UIImageLoader()

  private let imageLoader = ImageLoader()
  private var uuidMap = [UIImageView: UUID]()

  private init() {}

  func load(_ url: URL, for imageView: UIImageView) {
    let token = imageLoader.loadImage(url) { result in
        // 2
        defer { self.uuidMap.removeValue(forKey: imageView) }
        do {
          // 3
          let image = try result.get()
          DispatchQueue.main.async {
            imageView.image = image
          }
        } catch(let error) {
            print(error.localizedDescription)
        }
      }

      // 4
      if let token = token {
        uuidMap[imageView] = token
      }
  }

  func cancel(for imageView: UIImageView) {
    if let uuid = uuidMap[imageView] {
        imageLoader.cancelLoad(uuid)
        uuidMap.removeValue(forKey: imageView)
      }
  }
}


extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}

//
//  BookService.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-18.
//

import Foundation


final class BookService {
  private static let TIMEOUT_INTERVAL = 60.0

  static func getBooks(pageCount:String?, completion: @escaping (Swift.Result<BookList, NetworkError>) -> Void) {
    let urlconfig = URLSessionConfiguration.default
    urlconfig.timeoutIntervalForRequest = TIMEOUT_INTERVAL
    URLSession(configuration: urlconfig).dataTask(with: Request.getBooks(pageCount).urlRequest) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse,
            (200 ... 299).contains(httpResponse.statusCode)
      else {
        completion(.failure(NetworkError.error()))
        return
      }
      do {
        guard let data = data else {
          completion(.failure(NetworkError.error()))
          return
        }
        let result = try JSONDecoder().decode(BookList.self, from: data)
        completion(.success(result))
      } catch (let error) {
        print(error.localizedDescription)
        completion(.failure(NetworkError.error(code: httpResponse.statusCode)))
      }
    }.resume()
  }
}

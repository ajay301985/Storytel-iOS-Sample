//
//  NetworkRequest.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-18.
//

import Foundation

enum Request {
  case getBooks(String? = nil)

  // MARK: Internal

  var urlRequest: URLRequest {
    var urlRequest = URLRequest(url: URL(string: endpoint)!)
    urlRequest.httpMethod = httpMethod
    return urlRequest
  }

  // MARK: Private

  private var endpoint: String {
    switch self {
      case .getBooks(let pageCount):
        guard let count = pageCount else {
          return "https://api.storytel.net/search?query=harry"
        }
        return "https://api.storytel.net/search?query=harry&page=\(count)"
    }
  }

  private var httpMethod: String {
    switch self {
      case .getBooks:
        return "GET"
    }
  }
}

enum NetworkError: Error {
  case badRequest
  case requestTimeOut
  case noNetworkConnection
  case unknown

  // MARK: Internal

  var errorMessage: String {
    switch self {
      case .badRequest:
        return "Check your network connection"
      case .unknown:
        return "Internal Server error: Server is not responding"
      default:
        return "Not connected to network or poor connection, check your network"
    }
  }

  var debugDescription: String {
    switch self {
      case .badRequest:
        return "Bad API request"
      case .unknown:
        return "Internal Server error"
      default:
        return "Request Time out"
    }
  }

  static func error(code: Int? = 0) -> NetworkError {
    switch code {
      case 400:
        return .badRequest
      case 500:
        return .unknown
      default:
        return requestTimeOut
    }
  }
}

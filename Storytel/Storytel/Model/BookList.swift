//
//  BookList.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-19.
//

import Foundation

struct BookList: Decodable {
  var query: String
  var nextPageToken: String
  var totalCount: Int
  var books: [Book]
}

struct Book: Decodable {
  var title: String
  var authors: [Author]
  var narrators: [Narrator]?
  var cover: Cover?
}

extension Book {
  var authorNameList: String {
    let authorsName = (authors.map{String($0.name)}).joined(separator: ",")
    return "By: \(authorsName)"
  }

  var narratorNameList: String? {
    guard let narratorList = narrators, narratorList.isEmpty == false else {
      return nil
    }

    let authorsName = (narratorList.map{String($0.name)}).joined(separator: ",")
    return "With: \(authorsName)"
  }

}

struct Author: Decodable {
  var id: String
  var name: String
}

struct Cover: Decodable {
  var url: String?
  var width: Int
  var height: Int
}

struct Narrator: Decodable {
  var id: String
  var name: String
}

enum CodingKeys: String, CodingKey {
  case query, nextPageToken, totalCount, items, cover
}

extension BookList {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    query = try container.decode(String.self, forKey: .query)
    nextPageToken = try container.decode(String.self, forKey: .nextPageToken)
    totalCount = try container.decode(Int.self, forKey: .totalCount)
    books = try container.decode([Book].self, forKey: .items)
  }
}

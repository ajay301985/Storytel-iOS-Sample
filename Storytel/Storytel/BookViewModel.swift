//
//  BookViewModel.swift
//  Storytel
//
//  Created by Ajay Rawat on 2021-03-19.
//
/*!
 @discussion ViewModel class for interaction between  BookListViewController(Controller)
 and BookList (Data Model)
 */

import Foundation

final class BookViewModel {
  var bookList: BookList?
  var isLoading = false
  var books: [Book] = []

  var titleForHeader: String? {
    return bookList?.query.capitalized
  }

  var shouldHideHeader: Bool {
    return false
  }

  func getPlaces(completion: @escaping (Bool, NetworkError?) -> Void) {
    if isLoading == true, books.count == bookList?.totalCount ?? 0 { completion(true, nil)
      return
    }

    isLoading = true
    let pageCount = bookList?.nextPageToken
    BookService.getBooks(pageCount: pageCount) { [weak self] result in
      guard let self = self else { return }

      self.isLoading = false
      switch result {
        case .success(let bookList):
          self.bookList = bookList
          self.books += bookList.books
          completion(true, nil)
        case .failure(let error):
          completion(false, error)
      }
    }
  }
}

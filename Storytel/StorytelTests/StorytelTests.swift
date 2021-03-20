//
//  StorytelTests.swift
//  StorytelTests
//
//  Created by Ajay Rawat on 2021-03-18.
//

@testable import Storytel
import XCTest

class StorytelTests: XCTestCase {
  func testPlaceholderImage() throws {
    XCTAssertNotNil(UIImage(named: "placeholder.jpg"))
  }

  func testSingleAuthorNameSingleNarratorName() throws {
    let author = Author(id: "1", name: "Ajay Rawat")
    let narrator1 = Narrator(id: "2", name: "Stephen Fry")
    let book = Book(title: "5 AM Club", authors: [author], narrators: [narrator1], cover: nil)
    XCTAssertEqual(book.authorNameList, "By: Ajay Rawat")
    XCTAssertEqual(book.narratorNameList, "With: Stephen Fry")
  }

  func testAuthorNameList() throws {
    let author = Author(id: "1", name: "Ajay Rawat")
    let author1 = Author(id: "2", name: "Robin Sharma")
    let author2 = Author(id: "3", name: "Chetan Bhagat")
    let book = Book(title: "5 AM Club", authors: [author, author1, author2], narrators: nil, cover: nil)
    XCTAssertEqual(book.authorNameList, "By: Ajay Rawat,Robin Sharma,Chetan Bhagat")
    XCTAssertEqual(book.narratorNameList, nil)
  }

  func testNarratorNameList() throws {
    let author = Author(id: "1", name: "J.K Rowling")
    let narrator1 = Narrator(id: "1", name: "Stephen Fry")
    let narrator2 = Narrator(id: "2", name: "Jóhann Sigurðarson")

    let book = Book(title: "Harry Potter and the Deathly Hallows", authors: [author], narrators: [narrator1, narrator2], cover: nil)
    XCTAssertEqual(book.authorNameList, "By: J.K Rowling")
    XCTAssertEqual(book.narratorNameList, "With: Stephen Fry,Jóhann Sigurðarson")
  }

  func testUrlRequestWithPage() throws {
    let request = Request.getBooks("10")
    XCTAssertEqual(request.urlRequest.url?.description, "https://api.storytel.net/search?query=harry&page=10")
  }

  func testUrlRequestWithoutPage() throws {
    let requestWithoutPage = Request.getBooks()
    XCTAssertEqual(requestWithoutPage.urlRequest.url?.description, "https://api.storytel.net/search?query=harry")
  }
}

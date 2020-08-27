//
//  BookmarkCellViewModel.swift
//  ShioriUnitTests
//
//  Created by hikinit on 27/08/20.
//

import XCTest

class BookmarkCellViewModelTests: XCTestCase {
  var sut: BookmarkCellViewModel!
  var bookmark: Bookmark!

  override func setUp() {
    let library = TestLibrary()
    let series = library.getAllSeries().last

    bookmark = library.addBookmark(
      number: 1,
      kind: .chapter,
      name: nil,
      to: series!)
    sut = BookmarkCellViewModel(bookmark: bookmark)
  }

  override func tearDown() {
    sut = nil
    bookmark = nil
  }

  func testProperties() {
    XCTAssertEqual(sut.kind, "Chapter")
    XCTAssertEqual(sut.number, "1")

    bookmark.number = 1.5

    XCTAssertEqual(sut.number, "1.5")
    XCTAssertEqual(sut.description, "Chapter 1.5")

    bookmark.setKind(.volume)
    bookmark.number = 2

    XCTAssertEqual(sut.description, "Volume 2")

    let timestamp = "27 August 2020"
    bookmark.timestamp = createDate(timestamp)
    XCTAssertEqual(sut.timestamp, timestamp)
  }

  private func createDate(_ string: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMMM yyyy"
    formatter.timeZone = TimeZone.current

    return formatter.date(from: string)!
  }
}

//
//  LibraryTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 22/08/20.
//

import XCTest

class LibraryTests: XCTestCase {
  var sut: Library!

  override func setUp() {
    sut = Library(coreDataStack: TestCoreDataStack())
  }

  override func tearDown() {
    sut = nil
  }

  @discardableResult
  func addSeriesStub(title: String) -> Series {
    return sut.addSeries(
      title: title,
      kind: .webnovel,
      status: .onhold,
      website: "https://example.com"
    )
  }
}

// MARK: - Series
extension LibraryTests {
  func testAddSeries() {
    let newSeries = addSeriesStub(title: "Isaac")
    let allSeries = sut.seriesManager.getAll()

    XCTAssertEqual(allSeries.first, newSeries)
  }

  func testGetAllSeries() {
    var allSeries = sut.getAllSeries()

    XCTAssertEqual(allSeries.count, 0)

    addSeriesStub(title: "Overgeared")
    addSeriesStub(title: "Isaac")
    allSeries = sut.getAllSeries()

    XCTAssertEqual(allSeries.count, 2)
  }

  func testDeleteSeries() {
    let newSeries = addSeriesStub(title: "Overgeared")
    var allSeries = sut.getAllSeries()

    XCTAssertEqual(allSeries.count, 1)
    XCTAssertFalse(newSeries.isDeleted)

    sut.deleteSeries(newSeries)
    allSeries = sut.getAllSeries()

    XCTAssertEqual(allSeries.count, 0)
  }

  func testUpdateSeries() {
    let newSeries = addSeriesStub(title: "Overgeared")
    XCTAssertEqual(newSeries.title, "Overgeared")

    newSeries.title = "Overgearedd"
    sut.updateSeries(newSeries)
    XCTAssertEqual(newSeries.title, "Overgearedd")
  }
}

// MARK: - Bookmark
extension LibraryTests {
  func testAddBookmark() {
    let series = addSeriesStub(title: "Overgeared")
    let chapter1 = sut.addBookmark(number: 1, kind: .chapter, name: nil, to: series)
    let chapter2 = sut.addBookmark(number: 2, kind: .chapter, name: nil, to: series)

    XCTAssertEqual(series.arrayBookmarks.first, chapter1)
    XCTAssertEqual(series.arrayBookmarks.last, chapter2)
    XCTAssertNotEqual(series.arrayBookmarks.count, 0)
  }

  func testUpdateBookmark() {
    let series = addSeriesStub(title: "Overgeared")
    let chapter1 = sut.addBookmark(number: 1, kind: .chapter, name: nil, to: series)

    XCTAssertEqual(series.arrayBookmarks.first?.number, 1)

    chapter1.number = 1.5
    sut.updateBookmark(chapter1)

    XCTAssertEqual(series.arrayBookmarks.first?.number, 1.5)
  }

  func testDeleteBookmark() {
    let series = addSeriesStub(title: "Overgeared")
    let chapter1 = sut.addBookmark(number: 1, kind: .chapter, name: nil, to: series)
    let chapter2 = sut.addBookmark(number: 2, kind: .chapter, name: nil, to: series)

    XCTAssertEqual(series.arrayBookmarks.count, 2)

    sut.deleteBookmark(chapter2)

    XCTAssertEqual(series.arrayBookmarks.count, 1)
    XCTAssertEqual(series.arrayBookmarks.first, chapter1)
  }

  func testGetAllBookmark() {
    let series1 = addSeriesStub(title: "Overgeared")
    let series2 = addSeriesStub(title: "Isaac")
    var allBookmarks = sut.getAllBookmark()

    XCTAssertEqual(allBookmarks.count, 0)

    for series in [series1, series2] {
      sut.addBookmark(number: 1, kind: .chapter, name: nil, to: series)
      sut.addBookmark(number: 2, kind: .chapter, name: nil, to: series)
    }

    allBookmarks = sut.getAllBookmark()
    XCTAssertEqual(allBookmarks.count, 4)
  }

  func testGetBookmarkFromSeries() {
    let series1 = addSeriesStub(title: "Overgeared")
    let series2 = addSeriesStub(title: "Isaac")
    var bookmarkSeries1 = sut.getAllBookmarkFromSeries(series: series1)
    var bookmarkSeries2 = sut.getAllBookmarkFromSeries(series: series2)

    XCTAssertEqual(bookmarkSeries1.count, 0)
    XCTAssertEqual(bookmarkSeries2.count, 0)

    for number in 1...5 {
      sut.addBookmark(number: Float(number), kind: .chapter, name: nil, to: series1)
    }

    for number in 1...10 {
      sut.addBookmark(number: Float(number), kind: .chapter, name: nil, to: series2)
    }

    bookmarkSeries1 = sut.getAllBookmarkFromSeries(series: series1)
    bookmarkSeries2 = sut.getAllBookmarkFromSeries(series: series2)

    XCTAssertEqual(bookmarkSeries1.count, 5)
    XCTAssertEqual(bookmarkSeries2.count, 10)
  }
}

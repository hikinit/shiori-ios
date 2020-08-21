//
//  LibraryTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 21/08/20.
//

import XCTest

class LibraryTests: XCTestCase {
  var library: Library!
  var coreDataStack: CoreDataStack!

  override func setUp() {
    super.setUp()

    coreDataStack = TestCoreDataStack()
    library = Library(coreDataStack: coreDataStack)
  }

  override func tearDown() {
    super.tearDown()

    coreDataStack = nil
    library = nil
  }

  func testGetAllSeries() {
    var allSeries = library.getAllSeries()
    XCTAssertEqual(allSeries.count, 0)


    let newSeries = library.addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: "https://example.com"
    )

    allSeries = library.getAllSeries()

    XCTAssertEqual(allSeries.count, 1)
    XCTAssertEqual(allSeries.first, newSeries)
  }

  func testAddSeries() {
    let websiteUrlString = "https://example.com"
    let websiteUrl = URL(string: websiteUrlString)

    let series = library.addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: websiteUrlString
    )

    XCTAssertEqual(series.title, "Overgeared")
    XCTAssertEqual(series.kind, "Web Novel")
    XCTAssertEqual(series.status, "onhold")
    XCTAssertNotNil(series.id, "Id should not be nil")
    XCTAssertEqual(series.website, websiteUrl)
  }
}

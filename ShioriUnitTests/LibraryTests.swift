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
    coreDataStack = TestCoreDataStack()
    library = Library(coreDataStack: coreDataStack)
  }

  override func tearDown() {
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

    let newSeries = library.addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: websiteUrlString
    )

    XCTAssertEqual(newSeries.title, "Overgeared")
    XCTAssertEqual(newSeries.kind, "Web Novel")
    XCTAssertEqual(newSeries.status, "onhold")
    XCTAssertNotNil(newSeries.id, "Id should not be nil")
    XCTAssertEqual(newSeries.website, websiteUrl)

    let fetchedSeries = library.getAllSeries()
    XCTAssertEqual(fetchedSeries.first, newSeries)
  }

  func testDeleteSeries() {
    let newSeries = library.addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: "https://example.com"
    )
    var allSeries = library.getAllSeries()
    XCTAssertEqual(allSeries.count, 1)

    library.deleteSeries(newSeries)
    allSeries = library.getAllSeries()
    XCTAssertEqual(allSeries.count, 0)
  }

  func testUpdateSeries() {
    let newSeries = library.addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: "https://example.com"
    )

    newSeries.title = "Overgearedd"
    
    XCTAssertTrue(coreDataStack.context.hasChanges)

    library.update(newSeries)

    XCTAssertFalse(coreDataStack.context.hasChanges)
  }
}

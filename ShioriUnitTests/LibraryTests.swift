//
//  LibraryTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 22/08/20.
//

import XCTest

class LibraryTests: XCTestCase {
  var library: Library!

  override func setUp() {
    library = Library(coreDataStack: TestCoreDataStack())
  }

  override func tearDown() {
    library = nil
  }

  @discardableResult
  func addSeriesStub(title: String) -> Series {
    return library.addSeries(
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
    let allSeries = library.seriesManager.getAll()

    XCTAssertEqual(allSeries.first, newSeries)
  }

  func testGetAllSeries() {
    var allSeries = library.getAllSeries()

    XCTAssertEqual(allSeries.count, 0)

    addSeriesStub(title: "Overgeared")
    addSeriesStub(title: "Isaac")
    allSeries = library.getAllSeries()

    XCTAssertEqual(allSeries.count, 2)
  }

  func testDeleteSeries() {
    let newSeries = addSeriesStub(title: "Overgeared")
    var allSeries = library.getAllSeries()

    XCTAssertEqual(allSeries.count, 1)
    XCTAssertFalse(newSeries.isDeleted)

    library.deleteSeries(newSeries)
    allSeries = library.getAllSeries()

    XCTAssertEqual(allSeries.count, 0)
  }

  func testUpdateSeries() {
    let newSeries = addSeriesStub(title: "Overgeared")
    XCTAssertEqual(newSeries.title, "Overgeared")

    newSeries.title = "Overgearedd"
    library.updateSeries(newSeries)
    XCTAssertEqual(newSeries.title, "Overgearedd")
  }
}

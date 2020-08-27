//
//  SeriesListCellViewModelTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 23/08/20.
//

import XCTest

class SeriesListCellViewModelTests: XCTestCase {
  var sut: SeriesListCellViewModel!
  var series: Series!

  override func setUp() {
    series = TestLibrary().addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: "https://example.com"
    )

    sut = SeriesListCellViewModel(series: series)
  }

  override func tearDown() {
    sut = nil
    series = nil
  }

  func testProperties() {
    XCTAssertEqual(sut.title, series.title)
    XCTAssertEqual(sut.kind, series.kind)
    XCTAssertEqual(sut.status, series.status?.capitalized)
    XCTAssertTrue(sut.hasWebsite)
    XCTAssertNotNil(sut.websiteURL)
    XCTAssertEqual(sut.websiteURL, series.website)

    series.website = nil

    XCTAssertFalse(sut.hasWebsite)
    XCTAssertNil(sut.websiteURL)
  }
}

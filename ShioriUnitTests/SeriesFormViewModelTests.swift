//
//  SeriesFormViewModelTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 25/08/20.
//

import XCTest

class SeriesFormViewModelTests: XCTestCase {
  var sut: SeriesFormViewModel!
  var testLibrary: Library!
  var series: Series?

  override func setUp() {
    testLibrary = TestLibrary()
    sut = SeriesFormViewModel(
      library: testLibrary,
      series: nil
    )
  }

  override func tearDown() {
    testLibrary = nil
    sut = nil
  }

  func testViewDidLoadSeriesNotNil() {
    sut.viewDidLoad()

    XCTAssertNotNil(sut.title)
    XCTAssertNotNil(sut.kind)
    XCTAssertNotNil(sut.status)
    XCTAssertNotNil(sut.website)
  }

  func testPropertiesWhenSeriesIsNil() {
    let kind = Series.Kind.webnovel.rawValue
    let status = Series.Status.onhold.rawValue

    sut.title = "Overgeared"
    sut.kind = kind
    sut.status = status
    sut.website = "https://example.com"

    XCTAssertEqual(sut.title, "Overgeared")
    XCTAssertEqual(sut.kind, kind)
    XCTAssertEqual(sut.status, status)
    XCTAssertEqual(sut.website, "https://example.com")
    XCTAssertEqual(sut.viewControllerTitle, "New Series")
  }

  func testPropertiesWhenSeriesNotNil() {
    let series = testLibrary.addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: "https://example.com"
    )

    sut.series = series

    XCTAssertEqual(sut.title, series.title)
    XCTAssertEqual(sut.kind, series.kind)
    XCTAssertEqual(sut.status, series.status)
    XCTAssertEqual(sut.website, series.website?.absoluteString)
    XCTAssertEqual(sut.viewControllerTitle, series.title)
  }

  func testSaveNewSeries() {
    let kind = Series.Kind.webnovel.rawValue
    let status = Series.Status.onhold.rawValue

    sut.title = "Overgeared"
    sut.kind = kind
    sut.status = status
    sut.website = "https://example.com"

    guard let newSeries = sut.saveSeries() else {
      XCTFail("Can't save series")
      return
    }

    let index = testLibrary.getAllSeries().firstIndex(of: newSeries)
    XCTAssertNotNil(index)
  }

  func testUpdateSeries() {
    let series = testLibrary.addSeries(
      title: "Overgeared",
      kind: .webnovel,
      status: .onhold,
      website: "https://example.com"
    )

    sut.series = series
    sut.title = "Overgearedd"
    sut.kind = Series.Kind.lightnovel.rawValue
    sut.status = Series.Status.finished.rawValue
    sut.website = "https://example.net"

    let updatedSeries = sut.saveSeries()

    XCTAssertEqual(updatedSeries?.title, sut.title)
    XCTAssertEqual(updatedSeries?.kind, sut.kind)
    XCTAssertEqual(updatedSeries?.status, sut.status)
    XCTAssertEqual(updatedSeries?.website?.absoluteString, sut.website)
  }

  func testSaveButtonIsEnabled() {
    XCTAssertFalse(sut.saveButtonIsEnabled)

    sut.title = "FFF"

    XCTAssertFalse(sut.saveButtonIsEnabled)

    sut.kind = Series.Kind.lightnovel.rawValue
    sut.status = Series.Status.finished.rawValue

    XCTAssertFalse(sut.saveButtonIsEnabled)

    sut.title = "FFF-Class Trashero"
    
    XCTAssertTrue(sut.saveButtonIsEnabled)
  }
}

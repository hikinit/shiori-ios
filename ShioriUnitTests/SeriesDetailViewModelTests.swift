//
//  BookmarkCellViewModel.swift
//  ShioriUnitTests
//
//  Created by hikinit on 27/08/20.
//

import XCTest

class SeriesDetailViewModelTests: XCTestCase {
  var sut: SeriesDetailViewModel!
  var library: Library!
  var series: Series!

  override func setUp() {
    library = TestLibrary()

    series = library.getAllSeries().last

    sut = SeriesDetailViewModel(
      library: library,
      series: series
    )

    sut.viewDidLoad()
  }

  lazy var cellViewModels: [BookmarkCellViewModel] = {
    series.arrayBookmarks.map {
      BookmarkCellViewModel(bookmark: $0)
    }
  }()

  override func tearDown() {
    series = nil
    library = nil
    sut = nil
  }

  func testHeaderViewModelProperties() {
    XCTAssertEqual(sut.headerViewModel.title, series.title)
    XCTAssertEqual(sut.headerViewModel.kind, series.kind)
    XCTAssertEqual(sut.headerViewModel.status, series.status?.capitalized)
    XCTAssertEqual(sut.headerViewModel.websiteURL, series.website)
  }

  func testNumberOfRows() {
    XCTAssertEqual(sut.numberOfRows, cellViewModels.count)
  }

  func testCellViewModelForIndexPath() {
    let indexPath = IndexPath(item: 1, section: 0)
    XCTAssertEqual(sut.cellViewModelAtIndexPath(indexPath), cellViewModels[1])
  }

  func testReloadDataSource() {
    var reloaded = false

    sut.reloadDataSource {
      reloaded = true
    }

    XCTAssertTrue(reloaded)
  }

  func testDeleteThisSeries() {
    var deleted = false

    sut.deleteThisSeries {
      deleted = $0
    }

    XCTAssertTrue(deleted)
  }
}

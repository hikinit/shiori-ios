//
//  SeriesListViewModelTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 22/08/20.
//

import XCTest

class SeriesListViewModelTests: XCTestCase {
  var sut: SeriesListViewModel!
  var library: Library!

  override func setUp() {
    library = TestLibrary()
    sut = SeriesListViewModel(library: library)

    sut.viewDidLoad()
  }

  override func tearDown() {
    sut = nil
    library = nil
  }

  lazy var cellViewModels: [SeriesListCellViewModel] = {
    library.getAllSeries().map {
      SeriesListCellViewModel(series: $0)
    }
  }()
}

// MARK: - Test
extension SeriesListViewModelTests {
  func testNumberOfRows() {
    XCTAssertEqual(sut.numberOfRows, cellViewModels.count)
  }

  func testCellViewModelForIndexPath() {
    let indexPath = IndexPath(item: 1, section: 0)
    XCTAssertEqual(sut.cellViewModelsAtIndexPath(indexPath), cellViewModels[1])
  }

  func testDeleteSeries() {
    let cellViewModel = sut.cellViewModelsAtIndexPath(IndexPath(item: 1, section: 0))

    var deleted = false

    sut.deleteSeries(cellViewModel.series) {
      deleted = $0
    }

    XCTAssertTrue(deleted)
  }

  func testReloadDataSource() {
    var reloaded = false

    sut.reloadDataSource {
      reloaded = true
    }

    XCTAssertTrue(reloaded)
  }
}

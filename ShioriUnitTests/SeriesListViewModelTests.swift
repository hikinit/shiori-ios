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

extension SeriesListViewModelTests {
  func testNumberOfRows() {
    XCTAssertEqual(sut.numberOfRows, cellViewModels.count)
  }

  func testCellViewModelForIndexPath() {
    let indexPath = IndexPath(item: 1, section: 0)
    XCTAssertEqual(sut.cellViewModelsAtIndexPath(indexPath), cellViewModels[1])
  }
}

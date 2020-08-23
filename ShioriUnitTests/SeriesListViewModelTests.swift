//
//  SeriesListViewModelTests.swift
//  ShioriUnitTests
//
//  Created by hikinit on 22/08/20.
//

import XCTest

class SeriesListViewModelTests: XCTestCase {
  var sut: SeriesListViewModel!
  var testLibrary: Library!

  override func setUp() {
    sut = SeriesListViewModel(library: TestLibrary())
    testLibrary = TestLibrary()

    sut.viewDidLoad()
  }

  override func tearDown() {
    sut = nil
    testLibrary = nil
  }

  lazy var cellViewModels: [SeriesListCellViewModel] = {
    testLibrary.getAllSeries().map {
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

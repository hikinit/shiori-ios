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
}

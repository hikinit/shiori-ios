//
//  TestLibrary.swift
//  ShioriUnitTests
//
//  Created by hikinit on 23/08/20.
//

import Foundation

class TestLibrary: Library {
  init() {
    super.init(coreDataStack: TestCoreDataStack())

    for i in 1...5 {
      addSeries(
        title: "Series \(i)",
        kind: .webnovel,
        status: .finished,
        website: "https://series.com"
      )
    }
  }
}

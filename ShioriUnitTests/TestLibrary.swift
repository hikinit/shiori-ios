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
      let series = addSeries(
        title: "Series \(i)",
        kind: .webnovel,
        status: .finished,
        website: "https://series.com"
      )

      for j in 1...5 {
        addBookmark(
          number: Float(j),
          kind: .chapter,
          name: nil,
          to: series)
      }
    }
  }
}

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
  }
}

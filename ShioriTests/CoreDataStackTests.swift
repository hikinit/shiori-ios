//
//  ShioriTests.swift
//  ShioriTests
//
//  Created by hikinit on 20/08/20.
//

import XCTest
import CoreData

class CoreDataStackTests: XCTestCase {
  var stack: CoreDataStack!

  override func setUp() {
    stack = CoreDataStack()
  }

  func testManagedObjectModel() {
    let mom = CoreDataStack.managedObjectModel

    XCTAssertFalse(mom.entities.isEmpty, "Entity should not be empty")
  }


}

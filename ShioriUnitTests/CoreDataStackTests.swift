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
    let mom = CoreDataStack.model

    XCTAssertFalse(mom.entities.isEmpty, "Entity should not be empty")
  }

  func testPersistentContainer() {
    let container = stack.persistentContainer

    XCTAssertEqual(container.managedObjectModel, CoreDataStack.model)
  }

  func testSaveContext() {
    stack = TestCoreDataStack()
    let context = stack.context
    let series = Series(context: context)

    series.id = UUID()
    series.title = "Isaac"
    series.setKind(.webnovel)
    series.setStatus(.onhold)

    XCTAssertEqual(context.hasChanges, true, "Changes should be true")

    stack.saveContext(context)

    XCTAssertEqual(context.hasChanges, false, "Changes should be false")
  }
}

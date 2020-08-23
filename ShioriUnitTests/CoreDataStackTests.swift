//
//  ShioriTests.swift
//  ShioriTests
//
//  Created by hikinit on 20/08/20.
//

import XCTest
import CoreData

class CoreDataStackTests: XCTestCase {
  var sut: CoreDataStack!

  override func setUp() {
    sut = CoreDataStack()
  }

  func testManagedObjectModel() {
    let mom = CoreDataStack.model

    XCTAssertFalse(mom.entities.isEmpty, "Entity should not be empty")
  }

  func testPersistentContainer() {
    let container = sut.persistentContainer

    XCTAssertEqual(container.managedObjectModel, CoreDataStack.model)
  }

  func testSaveContext() {
    sut = TestCoreDataStack()
    let context = sut.context
    let series = Series(context: context)

    series.id = UUID()
    series.title = "Isaac"
    series.setKind(.webnovel)
    series.setStatus(.onhold)

    XCTAssertEqual(context.hasChanges, true, "Changes should be true")

    sut.saveContext(context)

    XCTAssertEqual(context.hasChanges, false, "Changes should be false")
  }
}

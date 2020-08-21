//
//  TestCoreDataStack.swift
//  ShioriTests
//
//  Created by hikinit on 20/08/20.
//

import Foundation
import CoreData

class TestCoreDataStack: CoreDataStack {
  override init() {
    super.init()

    let storeDescription = NSPersistentStoreDescription()
    storeDescription.type = NSInMemoryStoreType

    let container = NSPersistentContainer(
      name: CoreDataStack.name,
      managedObjectModel: CoreDataStack.model
    )

    container.persistentStoreDescriptions = [storeDescription]
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error {
        fatalError("Error load persistent store: \(error)")
      }
    })

    persistentContainer = container
  }
}

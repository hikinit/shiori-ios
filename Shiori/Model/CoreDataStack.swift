//
//  CoreDataStack.swift
//  Shiori
//
//  Created by hikinit on 20/08/20.
//

import Foundation
import CoreData

class CoreDataStack {
  static let shared = CoreDataStack()

  // MARK: - Static Properties
  static let name = "Shiori"
  static let model: NSManagedObjectModel = {
    let bundle = Bundle(for: CoreDataStack.self)
    guard
      let url = bundle.url(forResource: CoreDataStack.name, withExtension: "momd"),
      let mom = NSManagedObjectModel(contentsOf: url) else {
      fatalError("Can't load Core Data Model")
    }

    return mom
  }()

  // MARK: - Properties
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(
      name: CoreDataStack.name,
      managedObjectModel: CoreDataStack.model
    )

    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error {
        fatalError("Error load persistent store: \(error)")
      }
    })

    return container
  }()

  lazy var context: NSManagedObjectContext = {
    persistentContainer.viewContext
  }()

  // MARK: - Methods
  func saveContext(_ context: NSManagedObjectContext) {
    do {
      try context.save()
    } catch {
      fatalError("Error save context: \(error)")
    }
  }
}

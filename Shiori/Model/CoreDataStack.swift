//
//  CoreDataStack.swift
//  Shiori
//
//  Created by hikinit on 20/08/20.
//

import Foundation
import CoreData

class CoreDataStack {
  static let name = "Shiori"

  static let managedObjectModel: NSManagedObjectModel = {
    let bundle = Bundle(for: CoreDataStack.self)
    guard
      let url = bundle.url(forResource: CoreDataStack.name, withExtension: "momd"),
      let mom = NSManagedObjectModel(contentsOf: url) else {
      fatalError("Can't load Core Data Model")
    }

    return mom
  }()
}

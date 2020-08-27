//
//  Library.swift
//  Shiori
//
//  Created by hikinit on 21/08/20.
//

import Foundation
import CoreData

class EntityManager<Entity: NSManagedObject> {
  var coreDataStack: CoreDataStack
  var context: NSManagedObjectContext

  init(coreDataStack: CoreDataStack, context: NSManagedObjectContext) {
    self.coreDataStack = coreDataStack
    self.context = context
  }
}

extension EntityManager {
  func getAll() -> [Entity] {
    let request = NSFetchRequest<Entity>(entityName: String(describing: Entity.self))

    do {
      return try context.fetch(request)
    } catch {
      return []
    }
  }

  @discardableResult
  func add(_ entity: (NSManagedObjectContext) -> Entity) -> Entity {
    let entity = entity(context)

    coreDataStack.saveContext(context)
    return entity
  }

  func delete(_ entity: Entity) -> Bool {
    context.delete(entity)
    coreDataStack.saveContext(context)

    let isDeleted = entity.managedObjectContext == nil ? true : false
    return isDeleted
  }

  func update(_ entity: Entity) {
    if entity.isUpdated {
      coreDataStack.saveContext(context)
    }
  }
}

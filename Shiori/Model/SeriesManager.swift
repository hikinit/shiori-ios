//
//  Library.swift
//  Shiori
//
//  Created by hikinit on 21/08/20.
//

import Foundation
import CoreData

class SeriesManager {
  var coreDataStack: CoreDataStack
  var context: NSManagedObjectContext

  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
    self.context = coreDataStack.context
  }
}

// MARK: - Series
extension SeriesManager {
  func getAll() -> [Series] {
    let request: NSFetchRequest<Series> = Series.fetchRequest()

    do {
      return try context.fetch(request)
    } catch {
      return []
    }
  }

  @discardableResult
  func add(
    title: String,
    kind: Series.Kind,
    status: Series.Status,
    website: String) -> Series {
    let series = Series(context: context)

    series.setId()
    series.title = title
    series.setKind(kind)
    series.setStatus(status)
    series.website = URL(string: website)

    coreDataStack.saveContext(context)
    return series
  }

  func delete(_ series: Series) {
    context.delete(series)
    coreDataStack.saveContext(context)
  }

  func update(_ series: Series) {
    if series.isUpdated {
      coreDataStack.saveContext(context)
    }
  }
}
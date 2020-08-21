//
//  Library.swift
//  Shiori
//
//  Created by hikinit on 21/08/20.
//

import Foundation
import CoreData

class Library {
  var coreDataStack: CoreDataStack
  var context: NSManagedObjectContext

  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
    self.context = coreDataStack.context
  }
}

extension Library {
  func getAllSeries() -> [Series] {
    let request: NSFetchRequest<Series> = Series.fetchRequest()

    do {
      return try context.fetch(request)
    } catch {
      return []
    }

  }

  func addSeries(
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

    return series
  }
}

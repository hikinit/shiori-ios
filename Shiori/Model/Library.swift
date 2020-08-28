//
//  Library.swift
//  Shiori
//
//  Created by hikinit on 22/08/20.
//

import Foundation

class Library {
  var coreDataStack: CoreDataStack
  var seriesManager: EntityManager<Series>
  var bookmarkManager: EntityManager<Bookmark>

  init(coreDataStack: CoreDataStack) {
    self.coreDataStack = coreDataStack
    self.seriesManager = .init(coreDataStack: coreDataStack, context: coreDataStack.context)
    self.bookmarkManager = .init(coreDataStack: coreDataStack, context: coreDataStack.context)
  }
}

// MARK: - Series
extension Library {
  @discardableResult
  func addSeries(title: String,
                 kind: Series.Kind,
                 status: Series.Status,
                 website: String?) -> Series {
    let series = seriesManager.add {
      Series(context: $0,
             title: title,
             kind: kind,
             status: status,
             website: website
      )
    }

    return series
  }

  func getAllSeries() -> [Series] {
    let sortByTitle = NSSortDescriptor(key: "title", ascending: true)
    return seriesManager.getAll(sorts: [sortByTitle])
  }

  func deleteSeries(_ series: Series) -> Bool {
    return seriesManager.delete(series)
  }

  func updateSeries(_ series: Series) {
    seriesManager.update(series)
  }
}

// MARK: - Bookmark
extension Library {
  @discardableResult
  func addBookmark(number: Float,
                   kind: Bookmark.Kind,
                   name: String?,
                   to series: Series) -> Bookmark {
    let bookmark = bookmarkManager.add {
      Bookmark(context: $0,
               number: number,
               kind: kind,
               name: name
      )
    }

    bookmark.series = series
    bookmarkManager.update(bookmark)

    return bookmark
  }

  func updateBookmark(_ bookmark: Bookmark) {
    bookmarkManager.update(bookmark)
  }

  func deleteBookmark(_ bookmark: Bookmark) -> Bool {
    return bookmarkManager.delete(bookmark)
  }

  func getAllBookmarkFromSeries(series: Series) -> [Bookmark] {
    return series.arrayBookmarks
  }

  func getAllBookmark() -> [Bookmark] {
    return bookmarkManager.getAll()
  }
}

//
//  Series+CoreDataClass.swift
//  Shiori
//
//  Created by hikinit on 20/08/20.
//
//

import Foundation
import CoreData

@objc(Series)
public class Series: NSManagedObject {
  convenience init(context: NSManagedObjectContext,
                   title: String,
                   kind: Series.Kind,
                   status: Series.Status,
                   website: String?) {
    self.init(context: context)

    self.id = UUID()
    self.title = title
    self.kind = kind.rawValue
    self.status = status.rawValue

    if let website = website {
      self.website = URL(string: website)
    }
  }

  var arrayBookmarks: [Bookmark] {
    get {
      guard let bookmarks = bookmarks?.array as? [Bookmark] else {
        return []
      }

      return bookmarks
    }
  }

  func setStatus(_ status: Status) {
    self.status = status.rawValue
  }

  func setKind(_ kind: Kind) {
    self.kind = kind.rawValue
  }
}

extension Series {
  enum Kind: String, CaseIterable {
    case webnovel = "Web Novel"
    case lightnovel = "Light Novel"
    case comic = "Comic"
  }

  enum Status: String, CaseIterable {
    case reading,
         finished,
         onhold,
         dropped
  }
}


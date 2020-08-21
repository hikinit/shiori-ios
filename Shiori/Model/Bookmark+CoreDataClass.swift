//
//  Bookmark+CoreDataClass.swift
//  Shiori
//
//  Created by hikinit on 21/08/20.
//
//

import Foundation
import CoreData

@objc(Bookmark)
public class Bookmark: NSManagedObject {
  convenience init(context: NSManagedObjectContext,
                   number: Float,
                   kind: Kind,
                   name: String?) {
    self.init(context: context)
    self.setId()
    self.timestamp = Date()
    self.number = number
    self.setKind(kind)
    self.name = name
  }

  func setId(_ id: UUID = UUID()) {
    self.id = id
  }

  func setKind(_ kind: Kind) {
    self.kind = kind.rawValue
  }
}

extension Bookmark {
  enum Kind: String {
    case chapter, volume
  }
}


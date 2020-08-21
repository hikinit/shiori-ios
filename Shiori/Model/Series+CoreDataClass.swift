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
  func setStatus(_ status: Status) {
    self.status = status.rawValue
  }

  func setKind(_ kind: Kind) {
    self.kind = kind.rawValue
  }

  func setId(_ id: UUID = UUID()) {
    self.id = id
  }
}

extension Series {
  enum Kind: String {
    case webnovel = "Web Novel"
    case lightnovel = "Light Novel"
    case comic = "Comic"
  }

  enum Status: String {
    case reading,
         finished,
         onhold,
         dropped
  }
}

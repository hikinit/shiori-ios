//
//  Series+CoreDataProperties.swift
//  Shiori
//
//  Created by hikinit on 20/08/20.
//
//

import Foundation
import CoreData


extension Series {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<Series> {
    return NSFetchRequest<Series>(entityName: "Series")
  }

  @NSManaged public var cover: URL?
  @NSManaged public var id: UUID?
  @NSManaged public var kind: String?
  @NSManaged public var status: String?
  @NSManaged public var title: String?
  @NSManaged public var website: URL?

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

extension Series : Identifiable {}

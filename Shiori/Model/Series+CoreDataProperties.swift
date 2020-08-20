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

}

extension Series : Identifiable {

}

//
//  LocationDay+CoreDataProperties.swift
//  
//
//  Created by Admin on 10/12/20.
//
//

import Foundation
import CoreData


extension LocationDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationDay> {
        return NSFetchRequest<LocationDay>(entityName: "LocationDay")
    }

    @NSManaged public var date: String?
    @NSManaged public var woeid: Int64
    @NSManaged public var consolidatedLocationDay: NSSet?

}

// MARK: Generated accessors for consolidatedLocationDay
extension LocationDay {

    @objc(addConsolidatedLocationDayObject:)
    @NSManaged public func addToConsolidatedLocationDay(_ value: ConsolidatedLocationDay)

    @objc(removeConsolidatedLocationDayObject:)
    @NSManaged public func removeFromConsolidatedLocationDay(_ value: ConsolidatedLocationDay)

    @objc(addConsolidatedLocationDay:)
    @NSManaged public func addToConsolidatedLocationDay(_ values: NSSet)

    @objc(removeConsolidatedLocationDay:)
    @NSManaged public func removeFromConsolidatedLocationDay(_ values: NSSet)

}

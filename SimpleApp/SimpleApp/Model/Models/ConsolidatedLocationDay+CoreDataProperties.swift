//
//  ConsolidatedLocationDay+CoreDataProperties.swift
//  
//
//  Created by Admin on 10/12/20.
//
//

import Foundation
import CoreData


extension ConsolidatedLocationDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConsolidatedLocationDay> {
        return NSFetchRequest<ConsolidatedLocationDay>(entityName: "ConsolidatedLocationDay")
    }

    @NSManaged public var air_pressure: NSDecimalNumber?
    @NSManaged public var applicable_date: String?
    @NSManaged public var humidity: NSDecimalNumber?
    @NSManaged public var max_temp: NSDecimalNumber?
    @NSManaged public var min_temp: NSDecimalNumber?
    @NSManaged public var predictability: NSDecimalNumber?
    @NSManaged public var the_temp: NSDecimalNumber?
    @NSManaged public var visibility: NSDecimalNumber?
    @NSManaged public var weather_state_abbr: String?
    @NSManaged public var weather_state_name: String?
    @NSManaged public var wind_direction: String?
    @NSManaged public var wind_direction_compass: NSDecimalNumber?
    @NSManaged public var wind_speed: NSDecimalNumber?
    @NSManaged public var locationDay: LocationDay?

}

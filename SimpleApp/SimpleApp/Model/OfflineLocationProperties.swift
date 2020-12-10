//
//  OfflineLocationProperties.swift
//  SimpleApp
//
//  Created by Admin on 11/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation
import CoreData


extension OfflineLocations {
    
    @NSManaged var weather_state_name: String?
    @NSManaged var weather_state_abbr: String?
    @NSManaged var wind_direction_compass: String?
    @NSManaged var applicable_date: String?
    @NSManaged var min_temp: NSDecimalNumber?
    @NSManaged var max_temp: NSDecimalNumber?
    @NSManaged var the_temp: NSDecimalNumber?
    @NSManaged var wind_speed: NSDecimalNumber?
    @NSManaged var wind_direction: NSDecimalNumber?
    @NSManaged var air_pressure: NSDecimalNumber?
    @NSManaged var humidity: NSDecimalNumber?
    @NSManaged var visibility: NSDecimalNumber?
    @NSManaged var predictability: NSDecimalNumber?
    @NSManaged var recentSearches: RecentSearches?
    
}

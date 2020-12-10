//
//  RecentSearches+CoreDataProperties.swift
//  
//
//  Created by admin on 09/12/20.
//
//

import Foundation
import CoreData


extension RecentSearches {
    
    @NSManaged var latt_long: String?
    @NSManaged var title: String?
    @NSManaged var woeid: NSNumber?
    @NSManaged var syncedDate: String?
    @NSManaged var offlineLocations: NSSet?

}

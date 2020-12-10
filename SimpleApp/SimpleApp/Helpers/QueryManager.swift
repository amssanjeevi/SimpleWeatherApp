//
//  QueryManager.swift
//  SimpleApp
//
//  Created by Admin on 11/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation

class QueryManager {
    
    static let shared = QueryManager()
    
    private let whereOnEarthQuery = "woeid == %@"
    
    func queryByWoeid(id: NSNumber) -> NSPredicate {
        return NSPredicate(format: QueryManager.shared.whereOnEarthQuery, id)
    }
}

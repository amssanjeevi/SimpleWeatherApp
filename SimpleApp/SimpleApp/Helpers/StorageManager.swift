//
//  StorageManager.swift
//  SimpleApp
//
//  Created by Admin on 11/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    let isEditingStyleShown = "isEditingStyleShown"
    
    func getStoredData(for key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    func storeUserDefaults(value: Any?, for key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}

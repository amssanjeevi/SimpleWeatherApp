//
//  Data+Extensions.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation

extension Data {
    
    var serialise: AnyObject {
        guard let json = try? JSONSerialization.jsonObject(with: self, options: []) else { return [:] as AnyObject }
        return json as AnyObject
    }
}

//
//  NetworkManager.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseUrl = "https://www.metaweather.com/api/"
    
    func searchByLocationName(name: String, success: Success?) {
        guard Reachability.shared.isReachable() else { return }
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = baseUrl + Constants.UrlsExtensions.LocationQuery + encodedName!
        SessionsManager.shared.GET(urlString: url, success: success)
    }
    
    func searchByWhereOnEarth(woeId: Int, success: Success?) {
        guard Reachability.shared.isReachable() else { return }
        //let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = baseUrl + Constants.UrlsExtensions.whereOnEarthQuery + String(woeId)
        SessionsManager.shared.GET(urlString: url, success: success)
    }
    
    func searchByLatLong(lattitude: String, longitude: String, success: Success?) {
        guard Reachability.shared.isReachable() else { return }
        let url = baseUrl + Constants.UrlsExtensions.LocationQueryByCoordinates + "\(lattitude),\(longitude)"
        SessionsManager.shared.GET(urlString: url, success: success)
    }
}

//
//  PermissionManager.swift
//  SimpleApp
//
//  Created by Admin on 10/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class PermissionManager {
    
    static let shared = PermissionManager()
    let locationManager = CLLocationManager()
    
    func checkForLocationPermission(completion: @escaping () -> Void) {
        switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return
//                checkForLocationPermission(completion: completion)
            case .restricted: showPermissionNotAvailableInfo(for: "Location")
            case .denied: showPermissionNotAvailableInfo(for: "Location")
            case .authorizedAlways: completion()
            case .authorizedWhenInUse: completion()
        }
    }
    
    private func showPermissionNotAvailableInfo(for type: String) {
        var settingsUrlString = UIApplication.openSettingsURLString
        switch type {
            case "Location": settingsUrlString = settingsUrlString + "&path=LOCATION/\(Common.shared.bundleId())"
            default: break
        }
        let url = URL(string: settingsUrlString)!
        Notifier.shared.showAlert(
            alertTitle: "Oops",
            message: "Please enable \(type) services to utilize this action",
            firstButtonTitle: "Go To Settings",
            secondButtonTitle: "Close",
            firstAction: { UIApplication.shared.open(url, options: [:], completionHandler: nil) }
        ) {}
    }
}

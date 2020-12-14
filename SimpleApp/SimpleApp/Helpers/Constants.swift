//
//  Constants.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

struct Constants {
    
    struct FontName {
        static let Icomoon = "icomoon"
    }
    
    struct Entity {
        static let RecentSearches = "RecentSearches"
        static let OfflineLocations = "OfflineLocations"
    }
    
    struct TimeLimits {
        static let RequestTimeOut: TimeInterval = 30
        static let QuickAnimate: TimeInterval = 0.1
    }
    
    struct Size {
        static let StandardCellHeight: CGFloat = 50
        static let StandardHeaderHeight: CGFloat = 40
        static let BorderWidth: CGFloat = 1
        static let StandardCornerRadius: CGFloat = 4
        static let FooterToastHeight: CGFloat = 30
        static let DetailCellHeightPad: CGFloat = 250
        static let DetailCellHeightPhone: CGFloat = 250
    }
    
    struct FontSize {
        static let StandardHeaderSize: CGFloat = 16
        static let StandardDetailSize: CGFloat = 16
        static let VerySmallSize: CGFloat = 12
        static let SmallSize: CGFloat = 14
        static let LargeFont: CGFloat = 18
        static let VeryLargeFont: CGFloat = 20
        static let IconSize: CGFloat = 50
        static let ButtonIconSize: CGFloat = 20
    }
    
    struct Colors {
        static let DefaultBackground: UIColor = .white
        static let DefaultTableCellSeparator: UIColor = .lightGray
        static let DefaultText: UIColor = .black
        static let AppTheme: UIColor = UIColor(red: 46/255, green: 139/255, blue: 173/255, alpha: 1.0)
        static let Overlay: UIColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
        static let DetailTheme: UIColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        static let SpinnerBackground: UIColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1.0)
        static let PrimaryButton: UIColor = UIColor(red: 0/255, green: 118/255, blue: 237/255, alpha: 1.0)
        static let PrimaryButtonDisabled: UIColor = UIColor(red: 0/255, green: 118/255, blue: 237/255, alpha: 0.8)
        static let ShadowColor: UIColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
    }
    
    struct UrlsExtensions {
        static let LocationQuery = "location/search/?query="
        static let LocationQueryByCoordinates = "location/search/?lattlong="
        static let whereOnEarthQuery = "location/"
    }
    
    struct DateFormats {
        static let Format1 = "yyyy-MM-dd"
        static let Format2 = "MMMM dd, yyyy"
    }
}

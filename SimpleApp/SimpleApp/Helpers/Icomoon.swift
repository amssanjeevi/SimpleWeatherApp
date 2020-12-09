//
//  Icomoon.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

class IconFont: UIFont {
    
    enum Icon: String {
        case Snow = "sn"
        case Sleet = "sl"
        case Hail = "h"
        case Thunderstorm = "t"
        case HeavyRain = "hr"
        case LightRain = "lr"
        case Showers = "s"
        case HeavyCloud = "hc"
        case LightCloud = "lc"
        case Clear = "c"
    }
    
    static let shared = IconFont()
    
    func getFont(for iconName: Icon) -> String {
        
        switch iconName {
        case .Snow: return "\u{e97b}"
        case .Sleet: return "\u{e969}"
        case .Hail: return "\u{e900}"
        case .Thunderstorm: return "\u{e98f}"
        case .HeavyRain: return "\u{e911}"
        case .LightRain: return "\u{e93e}"
        case .Showers: return "\u{e952}"
        case .HeavyCloud: return "\u{e910}"
        case .LightCloud: return "\u{e97d}"
        case .Clear: return "\u{e98c}"
        }
    }
    
    func getFont(for iconName: Icon) -> UIImage? {
        
        switch iconName {
        case .Snow: return UIImage(named: "snow")
        case .Sleet: return UIImage(named: "sleet")
        case .Hail: return UIImage(named: "hail")
        case .Thunderstorm: return UIImage(named: "thunderstorm")
        case .HeavyRain: return UIImage(named: "heavyrain")
        case .LightRain: return UIImage(named: "lightrain")
        case .Showers: return UIImage(named: "showers")
        case .HeavyCloud: return UIImage(named: "heavycloud")
        case .LightCloud: return UIImage(named: "lightcloud")
        case .Clear: return UIImage(named: "clear")
        }
    }
}

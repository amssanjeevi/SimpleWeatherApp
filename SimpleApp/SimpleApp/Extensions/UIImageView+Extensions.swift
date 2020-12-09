//
//  UIImageView+Extensions.swift
//  SimpleApp
//
//  Created by admin on 10/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setWeatherImage(for identifier: String) {
        let imageName = IconFont.Icon.init(rawValue: identifier)
        image = IconFont.shared.getFont(for: imageName!)
        contentMode = .scaleAspectFit
    }
}

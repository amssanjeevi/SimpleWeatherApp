//
//  UILabel+Extension.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

extension UILabel {
    
    func commonTextAttributes() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
    }
    
    func dynamicTitleTheme(fontSize: CGFloat, fontColor: UIColor = Constants.Colors.DefaultText, fontWeight: UIFont.Weight = .semibold) {
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        textColor = fontColor
        commonTextAttributes()
    }
    
    func dynamicDetailTheme(fontSize: CGFloat, fontColor: UIColor = Constants.Colors.DefaultText, fontWeight: UIFont.Weight = .regular) {
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        textColor = fontColor
        commonTextAttributes()
    }
    
    func addLineBreak(lineCount: Int, mode: NSLineBreakMode = .byWordWrapping) {
        lineBreakMode = mode
        numberOfLines = lineCount
    }
    
    func setIconTitle(identifier: String) {
        let fontName = IconFont.Icon.init(rawValue: identifier)!
        setIconFont()
        text = IconFont.shared.getFont(for: fontName)
        textAlignment = .center
    }
    
    func setIconFont() {
        font = UIFont(name: Constants.FontName.Icomoon, size: Constants.FontSize.IconSize)!
    }
}

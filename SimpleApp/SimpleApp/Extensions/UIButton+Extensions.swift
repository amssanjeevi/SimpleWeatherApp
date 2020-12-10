//
//  UIButton+Extensions.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

extension UIButton {
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 0.8
            } else {
                alpha = 1
            }
        }
    }
    
    func exclusiveTouch() {
        self.isExclusiveTouch = true
    }
}

extension UIButton {
    
    func setLocationIcon() {
        exclusiveTouch()
        setIconFontAttributes(size: Constants.FontSize.ButtonIconSize)
        setIconFont(
            fontName: .Location,
            titleColor: Constants.Colors.PrimaryButton,
            backGroundColor: Constants.Colors.ShadowColor,
            disabledColor: Constants.Colors.PrimaryButtonDisabled
        )
    }
    
    private func setIconFontAttributes(size: CGFloat) {
        titleLabel?.font = UIFont(name: Constants.FontName.Icomoon , size: size)
    }
    
    private func setIconFont(fontName: IconFont.Icon, titleColor: UIColor, backGroundColor: UIColor, disabledColor: UIColor) {
        setTitleColor(titleColor, for: UIControl.State.normal)
        setTitleColor(disabledColor, for: UIControl.State.disabled)
        applyCornerRadius(of: Constants.Size.StandardCornerRadius)
        setTitle(IconFont.shared.getIconFont(for: fontName), for: UIControl.State.normal)
        setTitle(IconFont.shared.getIconFont(for: fontName), for: UIControl.State.selected)
        backgroundColor = backGroundColor
    }
}

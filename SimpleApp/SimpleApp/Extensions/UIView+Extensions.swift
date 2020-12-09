//
//  UIView+Extensions.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyDetailViewTheme() {
        backgroundColor = Constants.Colors.DetailTheme
    }
    
    func applyCornerRadius(of radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func addBorder(borderColor: UIColor) {
        layer.borderWidth = Constants.Size.BorderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    
    func applyBackgroundBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
    func scale(to xTimes: CGFloat) {
        transform = CGAffineTransform(scaleX: xTimes, y: xTimes)
    }
    
    func slide(from firstPosition: CGRect, to secondPosition: CGRect, duration: TimeInterval = Constants.TimeLimits.QuickAnimate, delay: TimeInterval = 0, completion: ((Bool) -> Void)?) {
        self.frame = firstPosition
        UIView.animate(withDuration: Constants.TimeLimits.QuickAnimate, delay: delay, options: .curveEaseInOut, animations: {
            self.frame = secondPosition
        }, completion: completion)
    }
}

import SnapKit

extension UIView {
    
    func spinnerConstraints(spinner: UIView, label: UIView) {
        spinner.snp.makeConstraints { (make) in
            make.width.equalTo(75)
            make.height.equalTo(75)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(snp.top).offset(10)
        }
        label.snp.makeConstraints { (make) in
            make.width.equalTo(snp.width)
            make.height.equalTo(20)
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(spinner.snp.bottom).offset(5)
        }
    }
    
    func spinnerBackGroundConstraints(background: UIView) {
        background.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(120)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
    func footerInfoConstraints(footerInfoView: UIView) {
        footerInfoView.snp.makeConstraints { (make) in
            make.bottom.equalTo(snp.bottom).offset(-60)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.height.equalTo(40)
        }
    }
    
    func addFooterIconAndInfoConstraints(iconView: UIView, label: UIView) {
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalTo(snp.left).offset(10)
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
            make.width.equalTo(20)
        }
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
            make.right.equalTo(snp.right)
        }
    }
}

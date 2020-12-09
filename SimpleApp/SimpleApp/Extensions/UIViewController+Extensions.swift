//
//  UIViewController+Extensions.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setTabBar(color: UIColor, andFontOf size: CGFloat) {
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : color,
                                           NSAttributedString.Key.font : UIFont.systemFont(ofSize: size, weight: .semibold)], for: .selected)
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: size, weight: .semibold)], for: .normal)
    }
    
    func addNavBarController(title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: self)
        navController.navigationBar.barTintColor = Constants.Colors.AppTheme
        navController.navigationBar.tintColor = .black
        navController.navigationBar.topItem?.title = title
        return navController
    }
    
    func addAndDisplay(child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        view.bringSubviewToFront(child.view)
        child.didMove(toParent: self)
    }
    
    func getRootController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
}

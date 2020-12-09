//
//  UITableView+Extensions.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

extension UITableView {
    
    func setDefaultsForTableView(
        hasFooterView: Bool = false,
        cellHeight: CGFloat? = Constants.Size.StandardCellHeight,
        headerHeight: CGFloat? = Constants.Size.StandardHeaderHeight,
        cellSeparatorColor: UIColor? = Constants.Colors.DefaultTableCellSeparator,
        allowSelection: Bool = true
    ) {
        if (!hasFooterView) {
            tableFooterView = UIView()
        }
        if let cellHeight = cellHeight {
            rowHeight = cellHeight
        }
        if let headerHeight = headerHeight {
            sectionHeaderHeight = headerHeight
        }
        separatorColor = cellSeparatorColor
        allowsSelection = allowSelection
    }
    
    func registerTableCell(for identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

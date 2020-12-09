//
//  SimpleTableCell.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

class SimpleTableCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.applyDetailViewTheme()
        applyDetailViewTheme()
        titleLabel.dynamicDetailTheme(fontSize: Constants.FontSize.StandardDetailSize)
    }
    
    func updateLabel(with title: String) {
        titleLabel.text = title
    }
}

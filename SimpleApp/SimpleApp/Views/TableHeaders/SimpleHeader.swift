//
//  SimpleHeader.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

class SimpleHeader: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.dynamicTitleTheme(fontSize: Constants.FontSize.StandardHeaderSize)
        applyDetailViewTheme()
    }
    
    func updateLabel(with title: String) {
        titleLabel.text = title
    }
}

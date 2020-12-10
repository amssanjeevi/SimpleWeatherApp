//
//  DetailViewController.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [AnyObject] = []
    let DetailCellIdentifier = "WeatherTableCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setDefaultsForTableView(
            cellHeight: UIDevice.current.userInterfaceIdiom == .pad ? Constants.Size.DetailCellHeightPad : Constants.Size.DetailCellHeightPhone
        )
        tableView.registerTableCell(for: DetailCellIdentifier)
        view.applyDetailViewTheme()
        tableView.applyDetailViewTheme()
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCellIdentifier, for: indexPath) as! WeatherTableCell
        cell.updateViewDetails(data: dataArray[indexPath.row])
        return cell
    }
}


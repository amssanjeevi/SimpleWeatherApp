//
//  HomeController.swift
//  SimpleApp
//
//  Created by Mohanasundaram on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation
import UIKit

protocol LocationSelectionDelegate {
    func loadInfo(for selectedLocation: AnyObject)
}

class HomeController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationSelectionDelegate: LocationSelectionDelegate?
    let SimpleCellIdentifier = "SimpleTableCell"
    var searchTableArray: [AnyObject] = []
    var recentSearches: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRecents()
        tableView.setDefaultsForTableView()
        tableView.registerTableCell(for: SimpleCellIdentifier)
        view.applyDetailViewTheme()
        tableView.applyDetailViewTheme()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSection = 1
        if !recentSearches.isEmpty { numberOfSection += 1 }
        return numberOfSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case 0:
                if searchTableArray.count > 0  {
                    return 40
                } else if searchBar.text?.count ?? 0 > 2 {
                    return 40
                }
            case 1:
                if recentSearches.count > 0 {
                    return 40
                }
            default: return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Common.shared.loadNib(named: "SimpleHeader") as? SimpleHeader
        switch section {
            case 0:
                if searchTableArray.count > 0  {
                    header?.updateLabel(with: "Search Results")
                } else if searchBar.text?.count ?? 0 > 2 {
                    header?.updateLabel(with: "Sorry, data not available for searched location")
                } else {
                    return nil
                }
            case 1: header?.updateLabel(with: "Recent Searches")
            default: return nil
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return searchTableArray.count
            case 1: return recentSearches.count
            default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCellIdentifier, for: indexPath) as! SimpleTableCell
        var displayData = ""
        switch indexPath.section {
            case 0: displayData = searchTableArray[indexPath.row].value(forKey: "title") as? String ?? ""
            case 1: displayData = recentSearches[indexPath.row].value(forKey: "title") as? String ?? ""
            default: displayData = ""
        }
        cell.updateLabel(with: displayData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                locationSelectionDelegate?.loadInfo(for: searchTableArray[indexPath.row])
                DispatchQueue.main.async {
                    self.addRecentSearches(data: self.searchTableArray[indexPath.row])
                    self.setRecents()
                    self.tableView.reloadData()
            }
            case 1: locationSelectionDelegate?.loadInfo(for: recentSearches[indexPath.row])
            default: break
        }
    }
}

extension HomeController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard searchBar.text?.count ?? 0 > 2 && searchTableArray.isEmpty else { return }
        searchByLocationName(name: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count > 2 else {
            self.searchTableArray = []
            DispatchQueue.main.async { self.tableView.reloadData() }
            return
        }
        searchByLocationName(name: searchText)
    }
    
    private func searchByLocationName(name: String) {
        NetworkManager.shared.searchByLocationName(name: name) { (locationNames) in
            guard let locationNames = locationNames as? [AnyObject] else { return }
            self.searchTableArray = locationNames
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
}

import CoreData

extension HomeController {
    
    func addRecentSearches(data: AnyObject) {
        let woeid = data.value(forKey: "woeid") as? NSNumber ?? 0
        let recents = Database.readData(entity: "RecentSearches", predicate: NSPredicate(format: "woeid == %@", woeid), sortDescriptors: nil, fetchLimit: nil) as! [RecentSearches]
        guard recents.count == 0 else { return }
        let recentSearches = NSEntityDescription.insertNewObject(forEntityName: "RecentSearches", into: Database.childContext!) as! RecentSearches
        recentSearches.title = data.value(forKey: "title") as? String
        recentSearches.latt_long = data.value(forKey: "latt_long") as? String
        recentSearches.woeid = woeid
        Database.saveMasterContext()
    }
    
    func setRecents() {
        let recents = Database.readData(entity: "RecentSearches", predicate: nil, sortDescriptors: nil, fetchLimit: nil) as! [RecentSearches]
        recentSearches = recents
    }
}

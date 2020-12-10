//
//  HomeController.swift
//  SimpleApp
//
//  Created by Mohanasundaram on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationSelectionDelegate {
    func loadInfo(for selectedLocation: RecentSearches)
}

class HomeController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationButton: UIButton!
    
    var locationSelectionDelegate: LocationSelectionDelegate?
    let SimpleCellIdentifier = "SimpleTableCell"
    var searchTableArray: [AnyObject] = []
    var recentSearches: [RecentSearches] = []
    var nearestCities: [AnyObject] = []
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        setRecents()
        tableView.setDefaultsForTableView()
        tableView.registerTableCell(for: SimpleCellIdentifier)
        view.applyDetailViewTheme()
        tableView.applyDetailViewTheme()
        locationButton.setLocationIcon()
        locationButton.applyCircularRadius()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        PermissionManager.shared.checkForLocationPermission {
            DispatchQueue.main.async {
                guard CLLocationManager.locationServicesEnabled() else { return }
                self.locationManager.startUpdatingLocation()
            }
        }
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSection = 2
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
                if !nearestCities.isEmpty {
                    return 40
                }
            case 2:
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
            case 1:
                if !nearestCities.isEmpty {
                    header?.updateLabel(with: "Your Nearest Cities")
                }
            case 2: header?.updateLabel(with: "Recent Searches")
            default: return nil
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return searchTableArray.count
            case 1: return nearestCities.count
            case 2: return recentSearches.count
            default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleCellIdentifier, for: indexPath) as! SimpleTableCell
        var displayData = ""
        switch indexPath.section {
            case 0: displayData = searchTableArray[indexPath.row].value(forKey: "title") as? String ?? ""
            case 1: displayData = nearestCities[indexPath.row].value(forKey: "title") as? String ?? ""
            case 2: displayData = recentSearches[indexPath.row].value(forKey: "title") as? String ?? ""
            default: displayData = ""
        }
        cell.updateLabel(with: displayData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0: self.loadNewInfo(data: searchTableArray[indexPath.row])
            case 1: self.loadNewInfo(data: nearestCities[indexPath.row])
            case 2: locationSelectionDelegate?.loadInfo(for: recentSearches[indexPath.row])
            default: break
        }
    }
    
    private func loadNewInfo(data: AnyObject) {
        let recentLocation = self.addAndGetRecentSearches(data: data)
        self.setRecents()
        locationSelectionDelegate?.loadInfo(for: recentLocation)
        DispatchQueue.main.async { self.tableView.reloadData() }
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
            self.nearestCities = []
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
    
    func addAndGetRecentSearches(data: AnyObject) -> RecentSearches {
        let woeid = data.value(forKey: "woeid") as? NSNumber ?? 0
        let recents = Database.readData(
            entity: "RecentSearches",
            predicate: QueryManager.shared.queryByWoeid(id: woeid),
            sortDescriptors: nil,
            fetchLimit: nil
        ) as! [RecentSearches]
        guard recents.count == 0 else { return recents.first! }
        let recentSearches = NSEntityDescription.insertNewObject(forEntityName: "RecentSearches", into: Database.childContext!) as! RecentSearches
        recentSearches.title = data.value(forKey: "title") as? String
        recentSearches.latt_long = data.value(forKey: "latt_long") as? String
        recentSearches.woeid = woeid
        recentSearches.syncedDate = Common.shared.getDateStamp()
        Database.saveMasterContext()
        return recentSearches
    }
    
    func setRecents() {
        let recents = Database.readData(entity: "RecentSearches", predicate: nil, sortDescriptors: nil, fetchLimit: nil) as! [RecentSearches]
        recentSearches = recents
    }
}

extension HomeController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Notifier.shared.showActivityIndicator(title: "Fetching Coordinates")
        guard let coordinates = manager.location?.coordinate else { return }
        locationManager.stopUpdatingLocation()
        NetworkManager.shared.searchByLatLong(
            lattitude: coordinates.latitude.description,
            longitude: coordinates.longitude.description
        ) { (fetchedData) in
            guard var locations = fetchedData as? [AnyObject], locations.count > 0 else {
                Notifier.shared.removeNotifier()
                return
            }
            locations.sort { (firstObject, nextObject) -> Bool in
                let firstDistance = firstObject.value(forKey: "distance") as! Int
                let nextDistance = nextObject.value(forKey: "distance") as! Int
                return firstDistance < nextDistance
            }
            self.searchTableArray = [locations.first!]
            locations.remove(at: 0)
            self.nearestCities = locations
            DispatchQueue.main.async {
                self.tableView.reloadData()
                Notifier.shared.removeNotifier()
            }
        }
    }
}

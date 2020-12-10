//
//  ContainerController.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    lazy var homeNavigation: UINavigationController = {
        let homeVc = HomeController()
        homeVc.locationSelectionDelegate = self
        //homeVc.addTabBarItem(title: "Home".localized, iconName: "Home", tag: 0)
        return homeVc.addNavBarController(title: "Weather")
    }()
    
    lazy var detailController: DetailViewController = {
        let detailVc = DetailViewController()
        detailVc.view.frame = self.view.bounds
        return detailVc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAndDisplay(child: homeNavigation)
    }

}

extension ContainerViewController: LocationSelectionDelegate {
    
    func loadInfo(for selectedLocation: RecentSearches) {
        guard isRefetchNeeded(selectedLocation: selectedLocation) else {
            guard let offlineData = selectedLocation.offlineLocations?.allObjects as? [OfflineLocations],
            offlineData.count > 0 else {
                fetchLocationDay(for: selectedLocation) { (_) in
                    self.loadInfo(for: selectedLocation)
                }
                return
            }
            loadDetailView(title: selectedLocation.title!, locationDay: offlineData)
            return
        }
        Database.deleteObjects(objects: selectedLocation.offlineLocations!.allObjects as [AnyObject])
        fetchLocationDay(for: selectedLocation) { (_) in
            self.loadDetailView(
                title: selectedLocation.title!,
                locationDay: selectedLocation.offlineLocations?.allObjects as! [OfflineLocations]
            )
        }
    }
    
    private func isRefetchNeeded(selectedLocation: RecentSearches) -> Bool {
        guard let dateString = selectedLocation.syncedDate else { return true }
        guard Common.shared.isMatchesTodayDate(date: dateString) else { return true }
        return false
    }
    
    private func fetchLocationDay(for location: RecentSearches, completion: @escaping Success) {
        let woeId = location.woeid as? Int ?? 0
        Notifier.shared.showActivityIndicator(title: "Fetching data")
        NetworkManager.shared.searchByWhereOnEarth(woeId: woeId) { (fetchedData) in
            Notifier.shared.removeNotifier()
            guard let object = fetchedData as AnyObject? else { return }
            guard let consolidatedObjects = object.value(forKey: "consolidated_weather") as? [AnyObject]
            else {
                Notifier.shared.showAlert(alertTitle: "Oops", message: "Could fetch data", firstButtonTitle: "Okay")
                return
            }
            self.addToOfflineData(dataArray: consolidatedObjects, parent: location)
            completion(nil)
        }
    }
    
    private func loadDetailView(title: String, locationDay: [OfflineLocations]) {
        DispatchQueue.main.async {
            self.detailController.dataArray = locationDay.sorted(by: { (first, next) -> Bool in
                return first.applicable_date?.compare(next.applicable_date ?? "", options: .anchored) == ComparisonResult.orderedAscending
            })
            self.detailController.title = title
            self.homeNavigation.pushViewController(self.detailController, animated: true)
        }
    }
    
    private func addToOfflineData(dataArray: [AnyObject], parent: RecentSearches) {
        for data in dataArray {
            let entity = Database.writeDataTo(entity: "OfflineLocations", data: data) as? OfflineLocations
            entity?.recentSearches = parent
        }
        Database.saveMasterContext()
    }
}

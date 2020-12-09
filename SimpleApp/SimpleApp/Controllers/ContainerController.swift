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
    
    func loadInfo(for selectedLocation: AnyObject) {
        let title = selectedLocation.value(forKey: "title") as? String
        let woeId = selectedLocation.value(forKey: "woeid") as? Int ?? 0
        Notifier.shared.showActivityIndicator(title: "Fetching data")
        NetworkManager.shared.searchByWhereOnEarth(woeId: woeId) { (fetchedData) in
            Notifier.shared.removeNotifier()
            if let consolidatedData = (fetchedData as AnyObject).value(forKey: "consolidated_weather") as? [AnyObject], consolidatedData.count > 0 {
                self.detailController.dataArray = consolidatedData
                DispatchQueue.main.async {
                    self.homeNavigation.pushViewController(self.detailController, animated: true)
                    self.detailController.title = title
                    self.detailController.tableView.reloadData()
                }
            } else {
                Notifier.shared.showAlert(alertTitle: "Oops", message: "Could fetch data", firstButtonTitle: "Okay")
            }
        }
    }
}

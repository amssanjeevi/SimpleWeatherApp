//
//  Common.swift
//  SimpleApp
//
//  Created by admin on 09/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation
import UIKit

class Common {
    
    static let shared = Common()
    
    func loadNib(named nibName: String) -> UIView {
        return UINib(nibName: nibName, bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func bundleId() -> String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    func startOfDay(date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    func getDateByAddingComponents(days: Int, toDate: Date) -> Date {
        var components = DateComponents()
        components.day = days
        return Calendar.current.date(byAdding: components, to: toDate)!
    }
    
    func getFormattedDate(inputFormat: String, outputFormat: String, dateString: String) -> String {
        let inputFormatter = DateFormatter()
        let outputFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.locale = locale
        outputFormatter.locale = locale
        inputFormatter.dateFormat = inputFormat
        outputFormatter.dateFormat = outputFormat
        let inputDate = inputFormatter.date(from: dateString)
        if let formattedDate = inputDate {
            if startOfDay(date: formattedDate) == startOfDay(date: Date()) {
                return "Today"
            }
            if startOfDay(date: formattedDate) == startOfDay(date: getDateByAddingComponents(days: 1, toDate: Date())) {
                return "Tomorrow"
            }
            return outputFormatter.string(from: formattedDate)
        }
        return ""
    }
}

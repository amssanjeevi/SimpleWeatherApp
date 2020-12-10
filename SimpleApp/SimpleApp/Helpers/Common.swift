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
    
    func getDateStamp() -> String {
        let dateFormatter = getDateFormatter()
        dateFormatter.dateFormat = Constants.DateFormats.Format1
        return dateFormatter.string(from: Date())
    }
    
    func isMatchesTodayDate(date: String) -> Bool {
        let formatter = getDateFormatter()
        formatter.dateFormat = Constants.DateFormats.Format1
        let today = formatter.string(from: Date())
        return date == today
    }
    
    func getDateByAddingComponents(days: Int, toDate: Date) -> Date {
        var components = DateComponents()
        components.day = days
        return Calendar.current.date(byAdding: components, to: toDate)!
    }
    
    func getFormattedDate(inputFormat: String, outputFormat: String, dateString: String) -> String {
        let inputFormatter = getDateFormatter()
        let outputFormatter = getDateFormatter()
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
    
    private func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = locale
        return dateFormatter
    }
    
    func roundOffTo(digits: Int, value: Any) -> String {
        let formatter = getRoundOffFormatter(format: getFormat(digitCount: digits))
        formatter.maximumFractionDigits = digits
        formatter.minimumFractionDigits = digits
        return formatter.string(from: value as! NSNumber)!
    }
    
    private func getRoundOffFormatter(format: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.numberStyle = .none
        formatter.positiveFormat = format
        formatter.negativeFormat = format
        formatter.decimalSeparator = "."
        formatter.usesGroupingSeparator = false
        formatter.roundingMode = .halfUp
        return formatter
    }
    
    private func getFormat(digitCount: Int) -> String {
        return "0." + String(repeating: "#", count: digitCount)
    }
}

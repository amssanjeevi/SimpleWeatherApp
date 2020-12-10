//
//  WeatherTableCell.swift
//  SimpleApp
//
//  Created by admin on 10/12/20.
//  Copyright © 2020 Amssanjeevi. All rights reserved.
//

import Foundation
import UIKit

class WeatherTableCell: UITableViewCell {
    
    @IBOutlet weak var weatherDate: UILabel!
    @IBOutlet weak var weatherStateIcon: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherStateName: UILabel!
    @IBOutlet weak var temperatureDetails: UILabel!
    @IBOutlet weak var minMaxTemperature: UILabel!
    @IBOutlet weak var leftStack: UIStackView!
    @IBOutlet weak var rightStack: UIStackView!
    
    var windCompass: UILabel = UILabel()
    var windSpeed: UILabel = UILabel()
    var windDirection: UILabel = UILabel()
    var airPressure: UILabel = UILabel()
    var humidity: UILabel = UILabel()
    var visibility: UILabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contentView.applyDetailViewTheme()
        applyDetailViewTheme()
        updateLabelsBasedOnDevice()
        weatherDate.dynamicTitleTheme(fontSize: Constants.FontSize.VeryLargeFont)
        weatherStateIcon.dynamicTitleTheme(fontSize: Constants.FontSize.IconSize)
        weatherStateName.dynamicTitleTheme(fontSize: Constants.FontSize.StandardHeaderSize)
        temperatureDetails.dynamicDetailTheme(fontSize: Constants.FontSize.SmallSize)
        minMaxTemperature.dynamicDetailTheme(fontSize: Constants.FontSize.SmallSize)
        windCompass.dynamicDetailTheme(fontSize: Constants.FontSize.SmallSize)
        windSpeed.dynamicDetailTheme(fontSize: Constants.FontSize.SmallSize)
        windDirection.dynamicDetailTheme(fontSize: Constants.FontSize.SmallSize)
        airPressure.dynamicDetailTheme(fontSize: Constants.FontSize.SmallSize)
        humidity.dynamicDetailTheme(fontSize: Constants.FontSize.SmallSize)
        visibility.dynamicDetailTheme(fontSize: Constants.FontSize.SmallSize)
    }
    
    func updateViewDetails(data: AnyObject) {
        let stateName = data.value(forKey: "weather_state_name") as? String ?? ""
        let iconType = data.value(forKey: "weather_state_abbr") as? String ?? ""
        let compass = data.value(forKey: "wind_direction_compass") as? String ?? ""
        let date = data.value(forKey: "applicable_date") as? String ?? ""
        let minTemp = data.value(forKey: "min_temp") as? Double ?? 0
        let maxTemp = data.value(forKey: "max_temp") as? Double ?? 0
        let temp = data.value(forKey: "the_temp") as? Double ?? 0
        let speed = data.value(forKey: "wind_speed") as? Double ?? 0
        let direction = data.value(forKey: "wind_direction") as? Double ?? 0
        let pressure = data.value(forKey: "air_pressure") as? Double ?? 0
        let humidness = data.value(forKey: "humidity") as? Double ?? 0
        let visibleness = data.value(forKey: "visibility") as? Double ?? 0
        let predictiveness = data.value(forKey: "predictability") as? Double ?? 0
        var tempString = String(format: "%.2f", temp)
        if tempString.contains(".00") { tempString = String(tempString.dropLast(3)) }
        var minTempString = String(format: "%.2f", minTemp)
        if minTempString.contains(".00") { minTempString = String(minTempString.dropLast(3)) }
        var maxTempString = String(format: "%.2f", maxTemp)
        if maxTempString.contains(".00") { maxTempString = String(maxTempString.dropLast(3)) }
        var speedString = String(format: "%.2f", speed)
        if speedString.contains(".00") { speedString = String(speedString.dropLast(3)) }
        var directionString = String(format: "%.2f", direction)
        if directionString.contains(".00") { directionString = String(directionString.dropLast(3)) }
        var pressureString = String(format: "%.2f", pressure)
        if pressureString.contains(".00") { pressureString = String(pressureString.dropLast(3)) }
        var humidnessString = String(format: "%.2f", humidness)
        if humidnessString.contains(".00") { humidnessString = String(humidnessString.dropLast(3)) }
        var visiblenessString = String(format: "%.2f", visibleness)
        if visiblenessString.contains(".00") { visiblenessString = String(visiblenessString.dropLast(3)) }
        var predictivenessString = String(format: "%.2f", predictiveness)
        if predictivenessString.contains(".00") { predictivenessString = String(predictivenessString.dropLast(3)) }
        weatherDate.text = Common.shared.getFormattedDate(
            inputFormat: Constants.DateFormats.Format1,
            outputFormat: Constants.DateFormats.Format2,
            dateString: date
        )
//        weatherStateIcon.setIconTitle(identifier: iconType)
        weatherIcon.setWeatherImage(for: iconType)
        weatherStateName.text = stateName
        temperatureDetails.addLineBreak(lineCount: 2)
        temperatureDetails.text = "Temperature \(tempString)°C"
        minMaxTemperature.text = "Min \(minTempString)°C ~ Max \(maxTempString)°C"
        windCompass.text = "Accuracy  \(predictivenessString)%"
        windSpeed.text = "Wind Speed \(speedString) mph"
        windDirection.text = "Wind Direction \(compass), \(directionString)°"
        airPressure.text = "Air Pressure \(pressureString) mbar"
        humidity.text = "Humidity \(humidnessString)%"
        visibility.text = "Visibility \(visiblenessString) miles"
        
    }
    
    func updateLabelsBasedOnDevice() {
        guard UIDevice.current.userInterfaceIdiom == .pad else {
            setLabelsForPhoneDisplay()
            return
        }
        setLabelsForPadDisplay()
    }
    
    func setLabelsForPadDisplay() {
        [windSpeed, airPressure, humidity].forEach { (label) in
            leftStack.addArrangedSubview(label)
        }
        [windDirection, visibility, windCompass].forEach { (label) in
            rightStack.addArrangedSubview(label)
        }
    }
    
    func setLabelsForPhoneDisplay() {
        rightStack.isHidden = true
        [windSpeed, windDirection, airPressure, visibility, humidity, windCompass].forEach { (label) in
            leftStack.addArrangedSubview(label)
        }
    }
}

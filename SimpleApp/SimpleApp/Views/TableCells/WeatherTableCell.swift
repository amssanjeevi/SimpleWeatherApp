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
    
    func updateViewDetails(data: OfflineLocations) {
        DispatchQueue.main.async {
            let iconType = data.weather_state_abbr ?? ""
            let temperatureData = data.the_temp ?? 0
            let windCompassData = data.wind_direction_compass ?? ""
            let minTemperatureData = data.min_temp ?? 0
            let maxTemperatureData = data.max_temp ?? 0
            let windSpeedData = data.wind_speed ?? 0
            let windDirectionData = data.wind_direction ?? 0
            let airPressureData = data.air_pressure ?? 0
            let humidityData = data.humidity ?? 0
            let visibilityData = data.visibility ?? 0
            let predictabilityData = data.predictability ?? 0
            
            self.weatherDate.text = Common.shared.getFormattedDate(
                inputFormat: Constants.DateFormats.Format1,
                outputFormat: Constants.DateFormats.Format2,
                dateString: data.applicable_date ?? ""
            )
            self.weatherIcon.setWeatherImage(for: iconType)
            self.weatherStateName.text = data.weather_state_name ?? ""
            self.temperatureDetails.text = "Temperature \(temperatureData)°C"
            self.minMaxTemperature.text = "Min \(minTemperatureData)°C ~ Max \(maxTemperatureData)°C"
            self.windCompass.text = "Accuracy  \(predictabilityData)%"
            self.windSpeed.text = "Wind Speed \(windSpeedData) mph"
            self.windDirection.text = "Wind Direction \(windCompassData), \(windDirectionData)°"
            self.airPressure.text = "Air Pressure \(airPressureData) mbar"
            self.humidity.text = "Humidity \(humidityData)%"
            self.visibility.text = "Visibility \(visibilityData) miles"
        }
        
    }
    
    func updateLabelsBasedOnDevice() {
//        guard UIDevice.current.userInterfaceIdiom == .pad else {
//            setLabelsForPhoneDisplay()
//            return
//        }
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

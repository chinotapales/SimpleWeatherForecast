//
//  CurrentViewModel.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation
import UIKit

struct CurrentViewModel {
 
    var current: Current
    
    var cityName: String {
        return (current.name)!
    }
    
    var dateTime: String {
        let date = Date(timeIntervalSince1970: (current.dt)!)
        return (date.getStringFromDate(dateFormat: .dayMonthDate))!
    }
    
    var icon: UIImage {
        let weather = (current.weather?.first)!
        return UIImage(named: (weather.icon)!)!
    }
    
    var description: String {
        let weather = (current.weather?.first)!
        return (weather.description?.capitalized)!
    }
    
    var aveTemp: String {
        let temp = (current.main?.temp)!
        let celsius = temp - 273.15
        
        return String(format: "%.0fºC", celsius)
    }
    
    var minTemp: String {
        let temp = (current.main?.tempMin)!
        let celsius = temp - 273.15
        
        return String(format: "%.0fºC", celsius)
    }
    
    var maxTemp: String {
        let temp = (current.main?.tempMax)!
        let celsius = temp - 273.15
        
        return String(format: "%.0fºC", celsius)
    }
    
    var sunriseTime: String {
        let date = Date(timeIntervalSince1970: (current.sys?.sunrise)!)
        return (date.getStringFromDate(dateFormat: .twelveHourTime))!
    }
    
    var sunsetTime: String {
        let date = Date(timeIntervalSince1970: (current.sys?.sunset)!)
        return (date.getStringFromDate(dateFormat: .twelveHourTime))!
    }
}

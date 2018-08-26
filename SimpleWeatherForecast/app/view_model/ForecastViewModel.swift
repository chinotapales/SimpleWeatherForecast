//
//  ForecastViewModel.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation
import UIKit

struct ForecastViewModel {
    
    var forecast: Forecast
    
    var date: String {
        let date = Date(timeIntervalSince1970: (forecast.dt)!)
        return (date.getStringFromDate(dateFormat: .day))!
    }
    
    var time: String {
        let date = Date(timeIntervalSince1970: (forecast.dt)!)
        return (date.getStringFromDate(dateFormat: .time))!
    }
    
    var icon: UIImage {
        let weather = (forecast.weather?.first)!
        return UIImage(named: (weather.icon)!)!
    }
    
    var description: String {
        let weather = (forecast.weather?.first)!
        return (weather.description?.capitalized)!
    }
    
    var aveTemp: String {
        let temp = (forecast.main?.temp)!
        let celsius = temp - 273.15
        
        return String(format: "%.0fºC", celsius)
    }
    
    var minTemp: String {
        let temp = (forecast.main?.tempMin)!
        let celsius = temp - 273.15
        
        return String(format: "%.0fºC", celsius)
    }
    
    var maxTemp: String {
        let temp = (forecast.main?.tempMax)!
        let celsius = temp - 273.15
        
        return String(format: "%.0fºC", celsius)
    }
    
    var windSpeed: String {
        let speed = (forecast.wind?.speed)!
        return String(format: "%.1fm/s", speed)
    }
    
    var windDirection: String {
        let directionArray = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let index = Int(((forecast.wind?.deg)! + 11.5).truncatingRemainder(dividingBy: 360) / 22.5)
        
        return directionArray[index]
    }
}

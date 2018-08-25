//
//  WeekViewModel.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation
import UIKit

struct WeekViewModel {
    
    var week: Week
    
    var cnt: Int {
        return (week.cnt)!
    }
    
    var forecasts: [ForecastViewModel] {
        let forecastArray = (week.list)!
        return forecastArray.map {
            ForecastViewModel(forecast: $0)
        }
    }
}

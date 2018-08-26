//
//  DateFormat.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation

enum DateFormat: String {
    
    case api = "yyyy-MM-dd'T'HH:mm:ssZ"
    case day = "EEEE"
    case dayMonthDate = "EEEE MMMM dd"
    case date = "MMMM dd"
    case time = "h:mm a"
    case twelveHourTime = "h:mma"
    
}

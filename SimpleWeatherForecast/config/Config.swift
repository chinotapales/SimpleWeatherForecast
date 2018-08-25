//
//  Config.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation

struct Config {
    
    static let baseUrlString: String = "https://api.openweathermap.org/data/2.5/"
    static let baseUrl: URL = URL(string: baseUrlString)!

}

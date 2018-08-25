//
//  Date+.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation

extension Date {
    
    fileprivate static let dateFormatter = DateFormatter()
    
    func getStringFromDate(dateFormat: DateFormat) -> String? {
        let dateFormatter = Date.dateFormatter
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: self)
    }
    
}

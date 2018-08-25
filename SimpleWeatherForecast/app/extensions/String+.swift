//
//  String+.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation

extension String {
    
    fileprivate static let dateFormatter = DateFormatter()
    
    func getDateFromString(dateFormat: DateFormat) -> Date? {
        let dateFormatter = String.dateFormatter
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.date(from: self)
    }
    
}

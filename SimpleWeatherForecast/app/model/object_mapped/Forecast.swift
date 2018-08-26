//
//  Forecast.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

class Forecast: Mappable {
    
    public var dt: Double?
    public var dtTxt: String?
    public var main: Main?
    public var weather: [Weather]?
    public var wind: Wind?
    
    public init() {
    }
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        dt <- map["dt"]
        dtTxt <- map["dt_txt"]
        main <- map["main"]
        weather <- map["weather"]
        wind <- map["wind"]
    }
}

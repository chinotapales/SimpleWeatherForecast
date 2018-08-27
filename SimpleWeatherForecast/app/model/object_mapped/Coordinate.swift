//
//  Coordinate.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

class Coordinate: Mappable {
    
    public var lon: Double?
    public var lat: Double?
    
    public init() {
    }
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        lon <- map["lon"]
        lat <- map["lat"]
    }
}

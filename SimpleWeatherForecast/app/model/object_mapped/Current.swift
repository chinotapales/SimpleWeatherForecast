//
//  Current.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

class Current: Mappable {
    
    public var cod: Int?
    public var name: String?
    public var id: Int?
    public var dt: Double?
    public var sys: System?
    public var wind: Wind?
    public var weather: [Weather]?
    public var main: Main?
    public var coord: Coordinate?
    
    public init() {
    }
            
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        cod <- map["cod"]
        name <- map["name"]
        id <- map["id"]
        dt <- map["dt"]
        sys <- map["sys"]
        wind <- map["wind"]
        weather <- map["weather"]
        main <- map["main"]
        coord <- map["coord"]
    }
}

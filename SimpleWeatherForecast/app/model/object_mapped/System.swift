//
//  System.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

class System: Mappable {
    
    public var country: String?
    public var sunrise: Double?
    public var sunset: Double?
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        country <- map["country"]
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
    }
}

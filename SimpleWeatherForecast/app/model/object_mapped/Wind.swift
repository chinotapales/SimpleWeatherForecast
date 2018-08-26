//
//  Wind.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

class Wind: Mappable {
    
    public var speed: Double?
    public var deg: Double?
    
    public init() {
    }
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}

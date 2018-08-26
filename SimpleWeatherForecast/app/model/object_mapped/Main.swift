//
//  Main.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

class Main: Mappable {
    
    public var temp: Double?
    public var tempMin: Double?
    public var tempMax: Double?
    
    public init() {
    }
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        temp <- map["temp"]
        tempMin <- map["temp_min"]
        tempMax <- map["temp_max"]
    }
}

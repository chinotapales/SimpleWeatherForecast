//
//  Week.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

class Week: Mappable {
    
    public var cod: Int?
    public var cnt: Int?
    public var list: [Forecast]?
    
    public required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        cod <- map["cod"]
        cnt <- map["cnt"]
        list <- map["list"]
    }
}

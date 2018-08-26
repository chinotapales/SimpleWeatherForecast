//
//  Weather.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

class Weather: Mappable {
    
    public var id: Int?
    public var main: String?
    public var description: String?
    public var icon: String?
    
    public init() {
    }
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}

//
//  LatLongParam.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

public class LatLongParam: QueryParam {
    
    private var lat: Double?
    private var lon: Double?
    
    public init(_ lat: Double,_ lon: Double) {
        super.init()
        self.lat = lat
        self.lon = lon
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        lat <- map["lat"]
        lon <- map["lon"]
    }
}

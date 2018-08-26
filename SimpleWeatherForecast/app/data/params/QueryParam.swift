//
//  QueryParam.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import ObjectMapper

public class QueryParam: Mappable {
    
    private var query: String?
    private var appId: String?
    
    public init() {
        let keychain = KeychainReadOnly(Keychain())
        self.appId = keychain.apiKey
    }
    
    public required init?(map: Map) {
    }
    
    public func mapping(map: Map) {
        query <- map["q"]
        appId <- map["appid"]
    }
    
    func set(_ query: String) {
        self.query = query
    }
    
}

//
//  ContentRepository.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Moya_ObjectMapper

class ContentRepository {
    
    var provider: Provider
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func getWeather(param: LatLongParam) -> Observable<Current> {
        return provider
            .rx
            .request(.weather(param: param))
            .asObservable()
            .mapErrors()
            .mapObject(Current.self)
            .map { current in
                return current
            }
    }
    
    func getForecast(param: LatLongParam) -> Observable<Week> {
        return provider
            .rx
            .request(.forecast(param: param))
            .asObservable()
            .mapErrors()
            .mapObject(Week.self)
            .map { week in
                return week
        }
    }

}

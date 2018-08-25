//
//  Service.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Alamofire
import Foundation
import Moya

class Provider: MoyaProvider<Service> {
    
    private static let timeOutDuration: TimeInterval = 120
    
    init(plugins: [PluginType], stub: Bool = false) {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Provider.timeOutDuration
        configuration.timeoutIntervalForResource = Provider.timeOutDuration
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let manager = Manager(configuration: configuration)
        
        guard stub else {
            super.init(manager: manager, plugins: plugins)
            return
        }
        
        super.init(stubClosure: MoyaProvider.immediatelyStub, manager: manager, plugins: plugins)
        
    }
    
}

enum Service {
    case forecast(param: LatLongParam)
    case weather(param: LatLongParam)
}

extension Service: TargetType {
    
    var baseURL: URL {
        return Config.baseUrl
    }
    
    var path: String {
        switch self {
        case .forecast:
            return "forecast"
        case .weather:
            return "weather"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .forecast, .weather:
            return .get
        }
    }
    
    var sampleData: Data {
        let data = Data()
        return data
    }
    
    var task: Task {
        switch self {
        case .forecast(let param):
            return .requestParameters(parameters: param.toJSON(), encoding: URLEncoding.default)
        case .weather(let param):
            return .requestParameters(parameters: param.toJSON(), encoding: URLEncoding.default)
        }
    }
    
    
    var authorization: String {
        switch self {
        case .forecast,
             .weather:
            return "Authorization"
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                "Accept-Encoding": "gzip, deflate, br",
                "Connection": "keep-alive",
                "Host": "api.openweathermap.org",
                "Upgrade-Insecure-Requests": "1"]
    }
    
}

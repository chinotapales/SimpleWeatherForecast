//
//  ApiError.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation

typealias ErrorMessageList = [String: [String]]

enum StringOrMessageList: Decodable {
    
    case string(String)
    
    case list(ErrorMessageList)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            self = try .string(container.decode(String.self))
        } catch DecodingError.typeMismatch {
            let messageList = try container.decode(ErrorMessageList.self)
            self = .list(messageList)
        }
    }
}


struct ApiError: Error, Decodable {
    
    var httpCode: Int?
    var message: StringOrMessageList?
    
    enum CodingKeys: String, CodingKey {
        case httpCode = "cod"
        case message = "message"
    }
    
}

extension ApiError {
    
    func getMessage() -> String? {
        
        guard message != nil else {
            return "Uknown Api Error."
        }
        
        switch message! {
        case .string(let message):
            return message
        case .list(let messageList):
            let list = Array(messageList.values)
            let combined = list.reduce([], +)
            return combined.joined(separator: "\n")
        }
        
    }
    
}

extension ApiError: LocalizedError {
    var errorDescription: String? { return getMessage() }
}

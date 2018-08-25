//
//  Keychain.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation
import KeychainSwift

class Keychain: KeychainSwift {
    
    enum Keys: String {
        case apiKey
    }
    
    var apiKey: String? {
        set {
            guard let apiKey = newValue else {
                self.delete(Keys.apiKey.rawValue)
                return
            }
            self.set(apiKey, forKey: Keys.apiKey.rawValue)
        }
        get {
            return self.get(Keys.apiKey.rawValue)
        }
    }
    
}

class KeychainReadOnly {
    
    var apiKey: String {
        return keychain.apiKey!
    }
    
    let keychain: Keychain
    
    init(_ keychain: Keychain) {
        self.keychain = keychain
    }
    
    
}

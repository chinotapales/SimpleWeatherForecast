//
//  AppColor.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit

enum AppColor: String {
    
    case backgroundColor
    case sunriseColor
    case sunsetColor
    case titleColor
    case subtitleColor
    case unknown
    
    var hex: Int {
        switch self {
        case .backgroundColor:      return 0x313643
        case .sunriseColor:      return 0xF0A867
        case .sunsetColor:  return 0xB381B7
        case .titleColor:  return 0xFFFFFF
        case .subtitleColor:  return 0xD5D6D9
        case .unknown: return 0x000000
        }
    }
    
    var uiColor: UIColor {
        return UIColor(hex: self.hex)
    }
    
}

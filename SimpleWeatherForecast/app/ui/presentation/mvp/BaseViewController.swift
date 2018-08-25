//
//  BaseViewController.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewController {
}

protocol Storyboarded {
    static var storyboardName: String { get }
    static var storyboardId: String { get }
    static func instanciate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instanciate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
    
}

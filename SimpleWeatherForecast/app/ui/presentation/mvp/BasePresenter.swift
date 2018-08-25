//
//  BasePresenter.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import Foundation

protocol BasePresenter: class {
    var view: BaseView? { get set }
    func attach(toView view: BaseView)
}

extension BasePresenter {
    
    func attach(toView view: BaseView) {
        self.view = view
    }
    
}

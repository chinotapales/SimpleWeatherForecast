//
//  UIViewController+.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showLoading() {
        let loadingView = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingView.label.text = "Loading"
        loadingView.animationType = .fade
    }
    
    func hideLoading() {
        MBProgressHUD.hide(for: self.view, animated: false)
    }
    
}

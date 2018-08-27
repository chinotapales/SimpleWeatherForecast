//
//  UIViewController+.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoading() {
        self.view.showActivityIndicator()
    }
    
    func hideLoading() {
        self.view.removeActivityIndicator()
    }
    
    func showAlertDialog(_ title: String, _ message: String, _ buttonTitle: String?, completion: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle ?? "OK", style: .cancel) { (_) in
            completion()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showErrorDialog(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

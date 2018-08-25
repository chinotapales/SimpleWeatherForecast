//
//  ForecastCollectionViewCell.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 26/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var windDetailsLabel: UILabel!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    
    static func getNib() -> UINib {
        return UINib(nibName: "ForecastCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(_ forecast: ForecastViewModel) {
        
        timeLabel.text = forecast.time
        forecastImageView.image = forecast.icon
        windDetailsLabel.text = "\(forecast.windDirection) \(forecast.windSpeed)"
        minMaxTempLabel.text = "\(forecast.minTemp) / \(forecast.maxTemp)"
    }
    
}

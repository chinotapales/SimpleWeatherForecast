//
//  DayHeaderTableViewCell.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 26/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit

class DayHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var forecastImageView: UIImageView!
    
    @IBOutlet weak var aveTempLabel: UILabel!
    
    @IBOutlet weak var dividerView: UIView!
    
    var forecasts = [ForecastViewModel]()
    
    static func getNib() -> UINib {
        return UINib(nibName: "DayHeaderTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(_ forecasts: [ForecastViewModel]) {
        self.forecasts = forecasts
        
        let forecast = forecasts.first
        
        dayLabel.text = forecast?.day
        dateLabel.text = forecast?.date
        aveTempLabel.text = forecast?.aveTemp
        
        forecastImageView.image = forecast?.icon
        forecastImageView.contentMode = .scaleAspectFit
    }

}

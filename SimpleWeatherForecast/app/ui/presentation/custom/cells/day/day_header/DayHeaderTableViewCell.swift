//
//  DayHeaderTableViewCell.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 26/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit

class DayHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var containerView: GradientView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var forecastImageView: UIImageView!
    
    @IBOutlet weak var aveTempLabel: UILabel!
    
    @IBOutlet weak var dividerView: UIView!
    
    var forecast: ForecastViewModel?
    var open = false
    
    static func getNib() -> UINib {
        return UINib(nibName: "DayHeaderTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(_ forecast: ForecastViewModel) {
        self.forecast = forecast
        
        dayLabel.text = forecast.day
        dateLabel.text = forecast.date
        aveTempLabel.text = forecast.aveTemp
        
        forecastImageView.image = forecast.icon
        forecastImageView.contentMode = .scaleAspectFit
    }
    
    func expandView(_ open: Bool) {
        
        self.open = open
        
        if open {
            containerView.startColor = AppColor.sunriseColor.uiColor
            containerView.endColor = AppColor.sunsetColor.uiColor
            
            dateLabel.textColor = UIColor.white
        }
        else {
            containerView.startColor = AppColor.backgroundColor.uiColor
            containerView.endColor = AppColor.backgroundColor.uiColor
            
            dateLabel.textColor = AppColor.subtitleColor.uiColor
        }
        
        dividerView.isHidden = open
        
        containerView.layoutSubviews()
    }

}

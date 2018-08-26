//
//  DayHeaderTableViewCell.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 26/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit

class DayHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var forecastImageView: UIImageView!
    
    @IBOutlet weak var minMaxTempLabel: UILabel!
    
    static func getNib() -> UINib {
        return UINib(nibName: "DayHeaderTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

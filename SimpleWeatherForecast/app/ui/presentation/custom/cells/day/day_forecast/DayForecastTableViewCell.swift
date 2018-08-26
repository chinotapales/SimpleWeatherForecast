//
//  DayForecastTableViewCell.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 26/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit

class DayForecastTableViewCell: UITableViewCell {
    
    struct cellIds {
        static let forecast = "forecast_cell"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var forecasts = [ForecastViewModel]()
    
    static func getNib() -> UINib {
        return UINib(nibName: "DayForecastTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initCollectionView()
    }
    
    func set(_ forecasts: [ForecastViewModel]) {
        self.forecasts = forecasts
        
        collectionView.reloadData()
        self.layoutSubviews()
    }
    
    func initCollectionView() {
        collectionView.register(ForecastCollectionViewCell.getNib(), forCellWithReuseIdentifier: cellIds.forecast)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension DayForecastTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIds.forecast, for: indexPath) as! ForecastCollectionViewCell
        
        let forecast = forecasts[indexPath.row]
        cell.set(forecast)
        cell.layoutIfNeeded()
        
        return cell
    }
    
}

extension DayForecastTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

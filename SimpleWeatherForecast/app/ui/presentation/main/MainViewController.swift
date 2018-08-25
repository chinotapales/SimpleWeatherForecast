//
//  MainViewController.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, BaseViewController, Storyboarded {
    
    static var storyboardName: String = "Main"
    static var storyboardId: String = "MainViewController"
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var averageTempLabel: UILabel!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    var current: CurrentViewModel?
    var sortedDays = [[ForecastViewModel]]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var presenter: MainPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach(toView: self)
        
        initLocationManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initLocation()
    }
    
    func initLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func initLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways:
            currentLocation = locationManager.location
            retreiveData()
            break
        case .authorizedWhenInUse:
            currentLocation = locationManager.location
            retreiveData()
            break
        case .denied:
            //TODO: SHOW POPUP TO REQUEST TURNING ON LOCATION
            break
        default:
            break
        }
        
    }
    
    func retreiveData() {
        if let currentLocation = self.currentLocation {
            let lat = currentLocation.coordinate.latitude
            let long = currentLocation.coordinate.longitude
            
            DispatchQueue.main.async {
                self.presenter?.getWeather(lat, long)
                self.presenter?.getForecast(lat, long)
            }
        }
        
    }
    
    func initCurrentUI() {
        
        //Toolbar Items
        cityNameLabel.text = current?.cityName
        currentDateLabel.text = current?.dateTime
        
        //Current Day Items
        forecastImageView.image = current?.icon
        averageTempLabel.text = current?.aveTemp
        minMaxTempLabel.text = "\((current?.minTemp)!) / \((current?.maxTemp)!)"
        descriptionLabel.text = current?.description
        
        //Daylight Items
        sunriseLabel.text = current?.sunriseTime
        sunsetLabel.text = current?.sunsetTime
        
    }

}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        initLocation()
    }
}

extension MainViewController: MainView {
    
    func showGetWeatherProgress() {
        showLoading()
    }
    
    func showGetWeatherSuccess(current: CurrentViewModel) {
        hideLoading()
        
        self.current = current
        
        initCurrentUI()
    }
    
    func showGetWeatherError(errorMessage: String) {
        hideLoading()
    }
    
    func showGetForecastProgress() {
        showLoading()
    }
    
    func showGetForecastSuccess(week: WeekViewModel) {
        hideLoading()
        
        let groupedWeekViewModel = Dictionary(grouping: week.forecasts) { (forecast) -> String in
            return forecast.date
        }
        
        let keys = groupedWeekViewModel.keys.sorted()
        
        keys.forEach { (key) in
            sortedDays.append((groupedWeekViewModel[key])!)
        }
        
    }
    
    func showGetForecastError(errorMessage: String) {
        hideLoading()
    }
    
}

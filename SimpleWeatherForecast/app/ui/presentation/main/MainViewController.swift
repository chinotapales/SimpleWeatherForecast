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
    
    struct cellIds {
        static let dayHeader = "header_cell"
        static let forecast = "forecast_cell"
    }
    
    @IBOutlet weak var contentStackView: UIStackView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    @IBOutlet weak var forecastImageView: UIImageView!
    @IBOutlet weak var averageTempLabel: UILabel!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    
    var current: CurrentViewModel?
    var currentForecast = [ForecastViewModel]()
    var sortedDays = [[ForecastViewModel]]()
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var presenter: MainPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.attach(toView: self)
        
        initLocationManager()
        
        setLayoutWidth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeViewController()
    }
    
    func initializeViewController() {
        initLocation()
        initCollectionView()
        initTableView()
    }
    
    
    func setLayoutWidth() {
        contentWidth.constant = UIScreen.main.bounds.width
        contentStackView.layoutIfNeeded()
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
    
    func initCollectionView() {
        collectionView.register(ForecastCollectionViewCell.getNib(), forCellWithReuseIdentifier: cellIds.forecast)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func initTableView() {
        tableView.register(DayHeaderTableViewCell.getNib(), forCellReuseIdentifier: cellIds.dayHeader)
        tableView.rowHeight = 56.0
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        tableViewHeight.constant = tableView.contentSize.height
        self.tableView.layoutIfNeeded()
    }
    
    func popFirstDay() {
        currentForecast = (sortedDays.first)!
        
        sortedDays.removeFirst()
        
        collectionView.reloadData()
    }

}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        initLocation()
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIds.forecast, for: indexPath) as! ForecastCollectionViewCell
        
        let forecast = currentForecast[indexPath.row]
        cell.set(forecast)
        cell.layoutIfNeeded()
        
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Testing Purposes
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIds.dayHeader, for: indexPath) as! DayHeaderTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}


//Handling of API Response Protocol
extension MainViewController: MainView {
    
    //GET /weather
    func showGetWeatherProgress() {
        showLoading()
    }
    
    //GET /weather
    func showGetWeatherSuccess(current: CurrentViewModel) {
        hideLoading()
        
        self.current = current
        
        initCurrentUI()
    }
    
    //GET /weather
    func showGetWeatherError(errorMessage: String) {
        hideLoading()
    }
    
    //GET /forecast
    func showGetForecastProgress() {
        showLoading()
    }
    
    //GET /forecast
    func showGetForecastSuccess(week: WeekViewModel) {
        hideLoading()
        
        let groupedWeekViewModel = Dictionary(grouping: week.forecasts) { (forecast) -> String in
            return forecast.date
        }
        
        let keys = groupedWeekViewModel.keys.sorted()
        
        keys.forEach { (key) in
            sortedDays.append((groupedWeekViewModel[key])!)
        }
        
        // For the Collection View Data Source
        popFirstDay()
        
    }
    
    //GET /forecast
    func showGetForecastError(errorMessage: String) {
        hideLoading()
    }
    
}

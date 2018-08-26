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
        static let dayForecast = "day_forcast_cell"
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
    
    //For expanding tableViewCells
    var open: [Bool] = []
    
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
        tableView.register(DayHeaderTableViewCell.getNib(), forHeaderFooterViewReuseIdentifier: cellIds.dayHeader)
        tableView.register(DayForecastTableViewCell.getNib(), forCellReuseIdentifier: cellIds.dayForecast)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 128.0
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    
    //To Make sure all Rows are Hidden
    func initExpanding() {
        sortedDays.forEach({
        _ in self.open.append(false)
        })
        
        tableView.reloadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        tableViewHeight.constant = tableView.contentSize.height
        
        //To Investigate
        //self.tableView.layoutIfNeeded()
    }
    
    func notifyDataChanged() {
        currentForecast = (sortedDays.first)!
        
        sortedDays.removeFirst()
        
        initExpanding()
        
        //Hide Current Day Forecasts if no data is available
        if currentForecast.isEmpty {
            collectionView.isHidden = true
        }
        else {
            collectionView.isHidden = false
        }
        
        collectionView.reloadData()
    }
    
    //To Update if the Cell is Expanded or Not.
    @objc func headerGestureHandler(_ recognizer: UITapGestureRecognizer) {
        let header = recognizer.view!
        let tag = header.tag
        open[tag] = !open[tag]
        
        //Toggle Open to Show That it's Selected
        let cell = tableView.headerView(forSection: tag) as! DayHeaderTableViewCell
        cell.open = open[tag]
        
        tableView.reloadSections([tag], with: .fade)
    }
    
    private func addTapGesture(for header: UIView, tag: Int) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(headerGestureHandler(_:)))
        header.tag = tag
        header.isUserInteractionEnabled = true
        header.addGestureRecognizer(gesture)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedDays.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard open[section] else {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIds.dayForecast, for: indexPath) as! DayForecastTableViewCell
        
        let dayForecast = sortedDays[indexPath.section]
        cell.set(dayForecast)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellIds.dayHeader) as! DayHeaderTableViewCell
        let forecast = sortedDays[section]
        header.set(forecast)
        header.expandView(open[section])
        
        addTapGesture(for: header, tag: section)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 56
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
        
        sortedDays.removeAll()
        
        let groupedWeekViewModel = Dictionary(grouping: week.forecasts) { (forecast) -> String in
            return forecast.date
        }
        
        let keys = groupedWeekViewModel.keys.sorted()
        
        keys.forEach { (key) in
            sortedDays.append((groupedWeekViewModel[key])!)
        }
        
        notifyDataChanged()
        
    }
    
    //GET /forecast
    func showGetForecastError(errorMessage: String) {
        hideLoading()
    }
    
}

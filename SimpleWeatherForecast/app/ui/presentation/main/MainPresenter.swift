//
//  MainPresenter.swift
//  SimpleWeatherForecast
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import RxSwift

protocol MainView: BaseView {
    
    func showGetWeatherProgress()
    func showGetWeatherSuccess(current: CurrentViewModel)
    func showGetWeatherError(errorMessage: String)
    
    func showGetForecastProgress()
    func showGetForecastSuccess(week: WeekViewModel)
    func showGetForecastError(errorMessage: String)
    
}

class MainPresenter: BasePresenter {
    
    weak var view: BaseView?
    var repository: ContentRepository
    var disposeBag: DisposeBag
    
    init(view: BaseView, repository: ContentRepository) {
        self.view = view
        self.repository = repository
        self.disposeBag = DisposeBag()
    }
    
    func getView() -> MainView? {
        return self.view as? MainView
    }
    
    func getWeather(_ lat: Double, _ lon: Double) {
        let param = LatLongParam(lat, lon)
        
        getView()?.showGetWeatherProgress()
        self.repository.getWeather(param: param).subscribe({ (event) in
            switch event {
            case .next(let current):
                
                let currentViewModel = CurrentViewModel(current: current)
                
                self.getView()?.showGetWeatherSuccess(current: currentViewModel)
            case .error(let error):
                self.getView()?.showGetWeatherError(errorMessage: error.localizedDescription)
            case .completed:
                break
            }
        }).disposed(by: disposeBag)
        
    }
    
    func getForecast(_ lat: Double, _ lon: Double) {
        let param = LatLongParam(lat, lon)
        
        getView()?.showGetForecastProgress()
        self.repository.getForecast(param: param).subscribe({ (event) in
            switch event {
            case .next(let week):
                
                let weekViewModel = WeekViewModel(week: week)
                
                self.getView()?.showGetForecastSuccess(week: weekViewModel)
            case .error(let error):
                self.getView()?.showGetForecastError(errorMessage: error.localizedDescription)
            case .completed:
                break
            }
        }).disposed(by: disposeBag)
        
    }
    
}

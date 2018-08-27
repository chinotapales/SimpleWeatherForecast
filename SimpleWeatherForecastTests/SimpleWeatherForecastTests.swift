//
//  SimpleWeatherForecastTests.swift
//  SimpleWeatherForecastTests
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import XCTest
import ObjectMapper

@testable import SimpleWeatherForecast

class SimpleWeatherForecastTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testApiKey() {
        let keychain = KeychainReadOnly(Keychain())
        
        //Failed Tests
        
//        XCTAssertNil(keychain.apiKey)
        
        //XCTAssertTests
        
        XCTAssertEqual(keychain.apiKey, "3f06d6c878a250d4bc5950f55198060a")
    }
    
    func testColors() {
        //Testing AppColor and it's convertions
        let backgroundColor = UIColor.init(red: 49, green: 54, blue: 67)
        let sunriseColor = UIColor.init(red: 240, green: 168, blue: 103)
        let sunsetColor = UIColor.init(red: 179, green: 129, blue: 183)
        
        //XCTAssertEqualTests
        
        XCTAssertEqual(backgroundColor, AppColor.backgroundColor.uiColor)
        XCTAssertEqual(sunriseColor, AppColor.sunriseColor.uiColor)
        XCTAssertEqual(sunsetColor, AppColor.sunsetColor.uiColor)
    }
    
    func testDateFormats() {
        let dt: Double = 1535292000
        let date = Date(timeIntervalSince1970: dt)
        
        //XCTAssertEqualTests
        
        //date Converts to your Respective Timezone (Test Passed on GMT+8:00 Timezone)
        XCTAssertEqual(date.getStringFromDate(dateFormat: .day), "Sunday")
        XCTAssertEqual(date.getStringFromDate(dateFormat: .dayMonthDate), "Sunday August 26")
        XCTAssertEqual(date.getStringFromDate(dateFormat: .date), "August 26")
        XCTAssertEqual(date.getStringFromDate(dateFormat: .time), "10:00 PM")
        XCTAssertEqual(date.getStringFromDate(dateFormat: .twelveHourTime), "10:00PM")
    }
    
    func testCurrentViewModel() {
        //Convert the sample weather.json response to a Current Object
        if let path = Bundle.main.path(forResource: "weather", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let currentJSON = jsonResult as? Dictionary<String, AnyObject> {
                    
                    //Initialize Current Object
                    let current = Mapper<Current>().map(JSON: currentJSON as [String: Any])
                    
                    //Convert Current Object to CurrentViewModel Struct
                    let currentViewModel = CurrentViewModel(current: current!)
                    
                    //Displaying Sample weather.json response values
                    print("-Begin Current Object-")
                    print(currentViewModel.cityName)
                    print(currentViewModel.dateTime)
                    print(currentViewModel.aveTemp)
                    print(currentViewModel.minTemp)
                    print(currentViewModel.maxTemp)
                    print(currentViewModel.sunriseTime)
                    print(currentViewModel.sunsetTime)
                    print(currentViewModel.description)
                    print(currentViewModel.icon)
                    print("-End Current Object-")
                    
                    //Failed Tests

//                    XCTAssertNil(current)
//                    XCTAssertNil(currentViewModel)

//                    XCTAssertEqual(currentViewModel.cityName, "San Fernando")
//                    XCTAssertEqual(currentViewModel.dateTime, "Saturday August 25")
//                    XCTAssertEqual(currentViewModel.aveTemp, "28º")
//                    XCTAssertEqual(currentViewModel.minTemp, "28C")
//                    XCTAssertEqual(currentViewModel.maxTemp, "28")
//                    XCTAssertEqual(currentViewModel.sunriseTime, "5:43A")
//                    XCTAssertEqual(currentViewModel.sunsetTime, "6:11P")
//                    XCTAssertEqual(currentViewModel.description, "overcast clouds")
//                    XCTAssertEqual(currentViewModel.icon, #imageLiteral(resourceName: "04d"))
                    
                    //XCTAssertEqualTests
                    
                    XCTAssertEqual(currentViewModel.cityName, "San Pedro")
                    XCTAssertEqual(currentViewModel.dateTime, "Sunday August 26")
                    XCTAssertEqual(currentViewModel.aveTemp, "28ºC")
                    XCTAssertEqual(currentViewModel.minTemp, "28ºC")
                    XCTAssertEqual(currentViewModel.maxTemp, "28ºC")
                    
                    //sunriseTime and sunsetTime Converts to your Respective Timezone (Test Passed on GMT+8:00 Timezone)
                    XCTAssertEqual(currentViewModel.sunriseTime, "5:43AM")
                    XCTAssertEqual(currentViewModel.sunsetTime, "6:11PM")
                    
                    XCTAssertEqual(currentViewModel.description, "Overcast Clouds")
                    XCTAssertEqual(currentViewModel.icon, #imageLiteral(resourceName: "04n"))
                }
            }
            catch {
                print("Error parsing JSON file")
            }
        }
        else {
            print("weather.json not found")
        }
        
    }
    
    func testForecastViewModel() {
        //Convert the sample forecast.json response to a Forecast Object
        if let path = Bundle.main.path(forResource: "forecast", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let weekJSON = jsonResult as? Dictionary<String, AnyObject> {
                    
                    //Initialize Current Object
                    let week = Mapper<Week>().map(JSON: weekJSON as [String: Any])
                    
                    //Initialize ForecastObject
                    let forecast = (week?.list?.first)!
                    
                    //Convert Current Object to CurrentViewModel Struct
                    let forecastViewModel = ForecastViewModel(forecast: forecast)
                    
                    //Displaying Sample weather.json response values
                    print("-Begin Forecast Object-")
                    print(forecastViewModel.day)
                    print(forecastViewModel.time)
                    print(forecastViewModel.minTemp)
                    print(forecastViewModel.maxTemp)
                    print(forecastViewModel.windSpeed)
                    print(forecastViewModel.windDirection)
                    print(forecastViewModel.description)
                    print(forecastViewModel.icon)
                    print("-End Current Object-")
                    
                    //XCTAssertEqualTests
                    
                    XCTAssertEqual(week?.cnt, 40)
                    
                    //day and time Converts to your Respective Timezone (Test Passed on GMT+8:00 Timezone)
                    XCTAssertEqual(forecastViewModel.day, "Monday")
                    XCTAssertEqual(forecastViewModel.time, "2:00 AM")
                    
                    XCTAssertEqual(forecastViewModel.minTemp, "26ºC")
                    XCTAssertEqual(forecastViewModel.maxTemp, "27ºC")
                    XCTAssertEqual(forecastViewModel.windSpeed, "3.8m/s")
                    XCTAssertEqual(forecastViewModel.windDirection, "WSW")
                    XCTAssertEqual(forecastViewModel.description, "Overcast Clouds")
                    XCTAssertEqual(forecastViewModel.icon, #imageLiteral(resourceName: "04n"))
                }
            }
            catch {
                print("Error Parsing JSON File")
            }
        }
    }
    
}

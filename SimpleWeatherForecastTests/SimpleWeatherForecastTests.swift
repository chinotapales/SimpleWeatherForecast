//
//  SimpleWeatherForecastTests.swift
//  SimpleWeatherForecastTests
//
//  Created by Carlo Gabriel Villalon Tapales on 25/08/2018.
//  Copyright © 2018 Chino Tapales. All rights reserved.
//

import XCTest
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
    
    func testCurrentViewModel() {
        //Convert the sample weather.json response to a Current Object
        if let path = Bundle.main.path(forResource: "weather", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let currentJSON = jsonResult as? Dictionary<String, AnyObject>,
                    let mainJSON = currentJSON["main"] as? Dictionary<String, AnyObject>,
                    let sysJSON = currentJSON["sys"] as? Dictionary<String, AnyObject>,
                    let weatherJSON = currentJSON["weather"] as? [Any] {
                    
                    //Initialize Current Object
                    let current = Current()
                    current.name = (currentJSON as [String: Any])["name"] as? String
                    current.dt = (currentJSON as [String: Any])["dt"] as? Double
                    
                    let main = Main()
                    main.temp = (mainJSON as [String: Any])["temp"] as? Double
                    main.tempMin = (mainJSON as [String: Any])["temp_min"] as? Double
                    main.tempMax = (mainJSON as [String: Any])["temp_max"] as? Double
                    
                    let sys = System()
                    sys.sunrise = (sysJSON as [String: Any])["sunrise"] as? Double
                    sys.sunset = (sysJSON as [String: Any])["sunset"] as? Double
                    
                    var weather = [Weather]()
                    let weatherItem = Weather()
                    weatherItem.description = (weatherJSON.first as! [String: Any])["description"] as? String
                    weatherItem.icon = (weatherJSON.first as! [String: Any])["icon"] as? String
                    
                    weather.append(weatherItem)
                    
                    current.main = main
                    current.sys = sys
                    current.weather = weather
                    
                    //Convert Current Object to CurrentViewModel Struct
                    let currentViewModel = CurrentViewModel(current: current)
                    
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
//
//                    XCTAssertNil(currentViewModel)
//
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
                    XCTAssertEqual(currentViewModel.sunriseTime, "5:43AM")
                    XCTAssertEqual(currentViewModel.sunsetTime, "6:11PM")
                    XCTAssertEqual(currentViewModel.description, "Overcast Clouds")
                    XCTAssertEqual(currentViewModel.icon, #imageLiteral(resourceName: "04n"))
                }
            }
            catch {
            }
        }
    }
    
}

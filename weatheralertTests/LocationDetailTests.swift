//
//  LocationDetailTests.swift
//  weatheralert
//
//  Created by Damien Laughton on 02/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import XCTest
@testable import weatheralert
import CoreData

class LocationDetailTests: XCTestCase {

  var viewController: weatheralert.LocationDetailViewController!
  var forecastDictionary: NSDictionary!
  var newForecast: weatheralert.Forecast?
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LocationDetailViewController") as! weatheralert.LocationDetailViewController
      
         forecastDictionary = ["dt_txt":"2014-07-23 09:00:00","wind":["speed":2.3,"deg":45]]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

  func testForecastCreation () {
    newForecast = weatheralert.Forecast(forecastDictionary:forecastDictionary)
    
    XCTAssertNotNil(newForecast?.dateOfForecast, "Locations must have a dateOfForecast")
  }

}

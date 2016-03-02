//
//  Forecast.swift
//  weatheralert
//
//  Created by Damien Laughton on 02/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation

struct Forecast {
  var windSpeed: Float = 0.0
  var windDirection: Float = 0.0
  var dateOfForecast: NSDate = NSDate()
  var timestamp: NSDate = NSDate()
  
  lazy var formatter: NSDateFormatter = {
    let temp = NSDateFormatter()
    temp.dateFormat = "yyyy-MM-dd HH:mm:ss" // ?
    return temp
  }()
  
  init (forecastDictionary: NSDictionary) {
    
    if let _ = forecastDictionary.objectForKey("wind") {
      
      let wind = forecastDictionary.objectForKey("wind") as! NSDictionary
      
      if let windSpeed = wind.objectForKey("speed") as? Float {
        self.windSpeed = windSpeed
      }
      
      if let windDirection = wind.objectForKey("deg") as? Float {
        self.windDirection = windDirection
      }
    }
    
    if let _ = forecastDictionary.objectForKey("dt_txt") {
      let possibleDateOfForecast = forecastDictionary.objectForKey("dt_txt") as! String
      
      if let dateOfForecast = formatter.dateFromString(possibleDateOfForecast) {
      
        self.dateOfForecast = dateOfForecast
      }
    }
    
    print(self)
  }
  
  init (forecastManagedObject: ForecastManagedObject) {
    if let windSpeed = forecastManagedObject.windSpeed {
      self.windSpeed = windSpeed.floatValue
    }
    
    if let windDirection = forecastManagedObject.windDirection {
      self.windDirection = windDirection.floatValue
    }
    
    if let dateOfForecast = forecastManagedObject.dateOfForecast {
      self.dateOfForecast = dateOfForecast
    }
    
    if let timestamp = forecastManagedObject.date_modified {
      self.timestamp = timestamp
    }
    
    print(self)
  }
}
//
//  Location.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation

struct Location {
  var name: String = ""
  var country: String = ""
  var locationId: Float = 0.0
  var windSpeed: Float = 0.0
  var windDirection: Float = 0.0
  var timestamp: NSDate = NSDate()
  
  
  init (weatherDictionary: NSDictionary) {
  
    if let name = weatherDictionary.objectForKey("name") as? String {
      self.name = name
    }
    
    if let _ = weatherDictionary.objectForKey("sys") {
      
      let sys = weatherDictionary.objectForKey("sys") as! NSDictionary
      
      if let country = sys.objectForKey("country") as? String {
        self.country = country
      }
    }
    
    if let locationId = weatherDictionary.objectForKey("id") as? Float {
      self.locationId = locationId
    }
    
    if let _ = weatherDictionary.objectForKey("wind") {
    
      let wind = weatherDictionary.objectForKey("wind") as! NSDictionary
      
      if let windSpeed = wind.objectForKey("speed") as? Float {
        self.windSpeed = windSpeed
      }
      
      if let windDirection = wind.objectForKey("deg") as? Float {
        self.windDirection = windDirection
      }

    }
    
    print(self)
  }
}

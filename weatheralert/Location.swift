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
  var locationId: String = ""
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
    
    if let locationId = weatherDictionary.objectForKey("id") as? Int {
      self.locationId = "\(locationId)"
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
  
  init (locationManagedObject: LocationManagedObject) {
    if let name = locationManagedObject.name {
      self.name = name
    }
    
    if let country = locationManagedObject.country {
      self.country = country
    }
    
    if let locationId = locationManagedObject.locationId {
      self.locationId = locationId
    }
    
    if let windSpeed = locationManagedObject.windSpeed {
      self.windSpeed = windSpeed.floatValue
    }
    
    if let windDirection = locationManagedObject.windDirection {
      self.windDirection = windDirection.floatValue
    }
    
    if let timestamp = locationManagedObject.date_modified {
      self.timestamp = timestamp
    }
    
    print(self)
  }
}

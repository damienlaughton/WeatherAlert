//
//  APIWeather.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation

class APIWeather: APIRoot {
  
  func weather (cityId cityId: String, completion: APICompletionHandler) {
    
    self.completionHandler = completion

    let parameters: NSDictionary = ["id": cityId]
    
    self.get("weather", parameters: parameters)
  }
  
  func weather (cities cities: [String], completion: APICompletionHandler) {
    
    self.completionHandler = completion
    
    let parameters: NSDictionary = ["id": cities]
    
    self.get("weather", parameters: parameters)
  }
  
  func weather (cityName cityName: String, country:String, completion: APICompletionHandler) {
    
    self.completionHandler = completion
    
    let parameters: NSDictionary = ["q": "\(cityName),\(country)"]
    
    self.get("weather", parameters: parameters)
  }

}
//
//  APIWeather.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation

class APIWeather: APIRoot {
  
  func weatherSingle (cityId cityId: String, completion: APICompletionHandler) {
    
    self.completionHandler = completion

    let parameters: NSDictionary = ["id": cityId]
    
    self.get("weather", parameters: parameters)
  }
  
  func weatherGroup (cities cities: String, completion: APICompletionHandler) {
    
    self.completionHandler = completion
    
    let parameters: NSDictionary = ["id": cities]
    
    self.get("group", parameters: parameters)
  }
  
  func weather (cityName cityName: String, country:String, completion: APICompletionHandler) {
    
    self.completionHandler = completion
    
    let parameters: NSDictionary = ["q": "\(cityName),\(country)"]
    
    self.get("weather", parameters: parameters)
  }

}
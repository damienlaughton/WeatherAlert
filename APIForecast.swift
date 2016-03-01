//
//  APIForecast.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation

class APIForecast: APIRoot {
  
  func fiveDayThreeHour (cityId cityId: String, completion: APICompletionHandler) {
    
    self.completionHandler = completion
    
    let parameters: NSDictionary = ["id": cityId]
    
    self.get("forecast", parameters: parameters)
  }
  
  func fiveDayThreeHour (cityName cityName: String, country:String, completion: APICompletionHandler) {
    
    self.completionHandler = completion
    
    let parameters: NSDictionary = ["q": "\(cityName),\(country)"]
    
    self.get("forecast", parameters: parameters)
  }
  
}
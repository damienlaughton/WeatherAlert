//
//  APIManagerSingleton.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Mobilolgy. All rights reserved.
//

import Foundation



class APIManagerSingleton {
  class var sharedInstance : APIManagerSingleton {
    struct Singleton {
      static let instance = APIManagerSingleton()
    }
    
    return Singleton.instance
  }
  
  required init() {
    
  }
  
  let apiKey = "bd8c011cc1437bb97815745edcece6d1"
  
  var oneRingToRuleThemAll: Bool = false
  
 
// MARK: - Path Constants
  
  lazy var livePath: String = {
    
    let temp = self.devPath
    
    return temp
    }()
  
  lazy var devPath: String = {
    
    let temp = "http://api.openweathermap.org/data/2.5/"
    
    return temp
    }()
  
  
}

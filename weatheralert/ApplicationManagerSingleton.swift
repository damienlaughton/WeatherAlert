//
//  ApplicationManagerSingleton.swift
//  weatheralert
//
//  Created by Damien Laughton on 24/02/2015.
//  Copyright © 2016 Mobilolgy. All rights reserved.
//

import Foundation
import UIKit

@objc class ApplicationManagerSingleton : NSObject {
  class var sharedInstance :ApplicationManagerSingleton {
    struct Singleton {
      static let instance = ApplicationManagerSingleton()
    }
    
    return Singleton.instance
  }
  
  lazy var identifierForVendor: String = {
    let temp = UIDevice.currentDevice().identifierForVendor!.UUIDString

    return temp
  }()
  
  func documentsDirectory () -> String
  {
    let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
    
    return documentsDirectory
  }
  
//  MARK: - Network Activity
  
  lazy var application : UIApplication = {
    let temp =  UIApplication.sharedApplication()
    
    return temp
  }()
  
  func showNetworkBusy () {
    self.application.networkActivityIndicatorVisible = true
  }
  
  func showNetworkIdle () {
    self.application.networkActivityIndicatorVisible = false
  }
  
//  MARK:- Vanilla Data
  
  lazy var vanillaString: String = {
    let temp = "XX99XXAWXX99XX"
    
    return temp
  }()
  
  private lazy var vanillaData : NSData? = {
    let temp = self.vanillaString
    let vanillaData = temp.dataUsingEncoding(NSUTF8StringEncoding)
    
    return vanillaData
  }()



  
  
}

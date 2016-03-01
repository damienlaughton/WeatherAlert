//
//  APIRoot.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation
import MobileCoreServices
import UIKit

typealias APICompletionHandler = (AnyObject, String) -> ()

public enum APIRootHTTPMethod {
  case Get, Post, Put, Delete
}

class APIRoot: NSObject {
  
  var connectionMethod : APIRootHTTPMethod = .Get
  var connectionEndPoint : String = String()
  var connectionPath : String = String()
  var connectionParameters : String = String()
  var connectionParametersDictionary : NSDictionary =  NSDictionary()
  
  var responseData : NSData = NSData()
  var responseStatusCode : Int = 0
  var responseString : String = String()
  var responseJSONObject : AnyObject = NSObject()
  var responseJSONDictionary : NSDictionary = NSDictionary()
  var responseJSONArray : NSArray = NSArray()
  
  var completionHandler: APICompletionHandler =  {
    (responseObject, status) -> Void in
  }
  
  func get (path: String, parameters: NSDictionary?) {
    
    var finalParameters = String()
    
    if let good_parameters = parameters {
      
      self.connectionParametersDictionary = good_parameters
      finalParameters = self.stringParameters(good_parameters)
    }
    
    self.get(path, parameters: finalParameters)
  }
  
  // MARK: - Private Functions
  
  private func stringParameters(userParameters: NSDictionary) -> String {
    
    let mutableParameters: NSMutableDictionary = userParameters.mutableCopy() as! NSMutableDictionary
    
    mutableParameters.setValue(APIManagerSingleton.sharedInstance.apiKey, forKey: "APPID")
    
    let stringParameters = mutableParameters.asParamatisedString()
    
    return stringParameters
  }
  
  private func get (path: String, parameters: String?) {
    
    self.call(APIRootHTTPMethod.Get, path: path, parameters: parameters)
  }
  
  var call_method: APIRootHTTPMethod?
  var call_path: String?
  var call_parameters: String?
  
  func late_call () {
    call(call_method!, path: call_path!, parameters: call_parameters)
  }
  
  private func call (method: APIRootHTTPMethod, path: String, parameters: String?) {
    
    if APIManagerSingleton.sharedInstance.oneRingToRuleThemAll == true {
      
      call_method = method
      call_path = path
      call_parameters = parameters
      
      performSelector("late_call", withObject: .None, afterDelay: 0.1)
      
      return
      
    } else {
      
      call_method = .None
      call_path = .None
      call_parameters = .None
    }
    
    APIManagerSingleton.sharedInstance.oneRingToRuleThemAll = true
    ApplicationManagerSingleton.sharedInstance.showNetworkBusy()
    
    self.connectionEndPoint = path
    
    var fullPath = APIManagerSingleton.sharedInstance.livePath
    
    fullPath = fullPath.stringByAppendingString(path).pathByPotentiallyAddingTerminatingSlash()
    
    if let good_parameters = parameters {
      
      self.connectionParameters = good_parameters
      
      if APIRootHTTPMethod.Post != method {
        
        fullPath = fullPath.stringByAppendingString(good_parameters)
      }
    }
    
    fullPath = fullPath.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    
    self.connectionPath = fullPath
    
    if let url = NSURL(string: fullPath) {
      
      let request = NSMutableURLRequest(URL: url)
      
      request.HTTPMethod = "GET"

      self.connectionMethod = method
      
      
      request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
      
      let session = NSURLSession.sharedSession()
      let task = session.dataTaskWithRequest(request){
        
        (data, response, error) -> Void in
        
        APIManagerSingleton.sharedInstance.oneRingToRuleThemAll = false
        ApplicationManagerSingleton.sharedInstance.showNetworkIdle()
        
        if error != .None {
          
          self.completionHandler("bad", error!.localizedDescription)
        } else {
          if let good_data = data {
            
            if let nshttpResponse = response as? NSHTTPURLResponse {
              let statusCode = nshttpResponse.statusCode
              
              self.responseData = good_data
              
              let responseObject = self.responseObject(good_data)
              
              self.completionHandler(responseObject, "\(statusCode)")
              
            } else {
              //Unknown Status
              abort()
            }
            
            
          }
          
        }
      }
      
      task.resume()
    }
  }
  
  func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: ((NSURLSessionAuthChallengeDisposition, NSURLCredential) -> Void)) {
  }
  
  func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: ((NSURLSessionAuthChallengeDisposition, NSURLCredential) -> Void)){
  }
  
  func responseObject(data: NSData) -> AnyObject {
    
    if let xyz = String(data: data, encoding: NSASCIIStringEncoding) {
      
      if xyz.characters.count > 0 {
        
        let firstChar = xyz[xyz.startIndex]
        
        if ((firstChar == "{") || (firstChar == "[")) {
          
          if let x = data.asJSONObject() {
            
            self.responseJSONObject = x
            
            if (true == x.isKindOfClass(NSDictionary)) {
              
              self.responseJSONDictionary = (x as? NSDictionary)!
              
              return self.responseJSONDictionary
            }
            
            if (true == x.isKindOfClass(NSArray)) {
              self.responseJSONArray = (x as? NSArray)!
              
              return self.responseJSONArray
            }
            
            return x
          }
          
        } else {
          //It's not a JSON response
          let error: NSError = NSError(domain: "com.json.fail", code: 0, userInfo: ["message" : "The server response was not JSON"])
          
          return error
        }
        
      } else {
        //It's not a JSON response
        let error: NSError = NSError(domain: "com.json.fail", code: 0, userInfo: ["message" : "The server response was empty"])
        
        return error
      }
    }
    
    let error: NSError = NSError(domain: "com.json.fail", code: 0, userInfo: ["message" : "Unable to understand JSON response"])
    
    return error
  }
}
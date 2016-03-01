//
//  NSDictionary+asParamatisedString.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation

public extension NSDictionary {
  func asParamatisedString() -> String {
    var paramatisedString: String = "?"
    
    for (key, value) in self {
//      if ("?" != paramatisedString){
//        paramatisedString = paramatisedString.stringByAppendingString("&")
//      }
    
      if value is NSArray {
        //loop through the values
        
        for v in value as! NSArray {
          
          if ("?" != paramatisedString){
            paramatisedString = paramatisedString.stringByAppendingString("&")
          }
          
          paramatisedString = paramatisedString.stringByAppendingString(key as! NSString as String)
          paramatisedString = paramatisedString.stringByAppendingString("=")
          paramatisedString = paramatisedString.stringByAppendingString(v as! NSString as String)
          
        }
        
      } else {
      
        if ("?" != paramatisedString){
          paramatisedString = paramatisedString.stringByAppendingString("&")
        }
      
        paramatisedString = paramatisedString.stringByAppendingString(key as! NSString as String)
        paramatisedString = paramatisedString.stringByAppendingString("=")
        paramatisedString = paramatisedString.stringByAppendingString(value as! NSString as String)
      }
    }
    
    paramatisedString = paramatisedString.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
    
    return paramatisedString
  }
}
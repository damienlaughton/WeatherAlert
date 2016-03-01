//
//  NSData+asJSONObject.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation

public extension NSData {
  func asJSONObject() -> AnyObject? {

    let object : AnyObject?
    do {
      object = try NSJSONSerialization.JSONObjectWithData(self, options: .MutableContainers)
    } catch {
      object = .None
    }
    return object
  }
}
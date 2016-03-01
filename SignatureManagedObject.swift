//
//  SignatureManagedObject.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation
import CoreData

@objc(SignatureManagedObject)
class SignatureManagedObject: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

  func sign() {
    let now = NSDate()
    
    if date_created == .None {
      date_created = now
    }
    
    date_modified = now
  }
}

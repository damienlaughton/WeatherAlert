//
//  String+withTerminatingSlash.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation

public extension String {

  func pathByPotentiallyAddingTerminatingSlash() -> String {
    
    var temp = self
    
    let lastCharacter = temp[temp.endIndex.predecessor()]
    
    if (lastCharacter != "/") {
      temp = self.stringByAppendingString("/")
    }
    
    return temp
  }

}
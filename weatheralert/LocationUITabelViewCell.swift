//
//  LocationUITabelViewCell.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation
import UIKit

class LocationUITabelViewCell: UITableViewCell {
  
  var location: Location? = .None
  
  func configure(location: Location) {
    self.location = location
  }
  
}
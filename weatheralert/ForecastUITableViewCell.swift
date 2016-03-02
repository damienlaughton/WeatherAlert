//
//  ForecastUITableViewCell.swift
//  weatheralert
//
//  Created by Damien Laughton on 02/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation
import UIKit

class ForecastUITableViewCell: UITableViewCell {

  var forecast: Forecast? = .None
  
  func configure(forecast: Forecast) {
    
    self.forecast = forecast
  }
}
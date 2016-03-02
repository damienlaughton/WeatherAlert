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

  @IBOutlet weak var borderUIView: UIView!
  @IBOutlet weak var dateUILabel: UILabel!
  
  @IBOutlet weak var windArrowUIImageView_1: UIImageView!
  @IBOutlet weak var windArrowHeightConstraint_1: NSLayoutConstraint!
  @IBOutlet weak var windSpeedUILabel_1: UILabel!
  @IBOutlet weak var windDirectionUILabel_1: UILabel!

  @IBOutlet weak var windArrowUIImageView_2: UIImageView!
  @IBOutlet weak var windArrowHeightConstraint_2: NSLayoutConstraint!
  @IBOutlet weak var windSpeedUILabel_2: UILabel!
  @IBOutlet weak var windDirectionUILabel_2: UILabel!
  
  @IBOutlet weak var windArrowUIImageView_3: UIImageView!
  @IBOutlet weak var windArrowHeightConstraint_3: NSLayoutConstraint!
  @IBOutlet weak var windSpeedUILabel_3: UILabel!
  @IBOutlet weak var windDirectionUILabel_3: UILabel!
  
  @IBOutlet weak var windArrowUIImageView_4: UIImageView!
  @IBOutlet weak var windArrowHeightConstraint_4: NSLayoutConstraint!
  @IBOutlet weak var windSpeedUILabel_4: UILabel!
  @IBOutlet weak var windDirectionUILabel_4: UILabel!
  
  @IBOutlet weak var windArrowUIImageView_5: UIImageView!
  @IBOutlet weak var windArrowHeightConstraint_5: NSLayoutConstraint!
  @IBOutlet weak var windSpeedUILabel_5: UILabel!
  @IBOutlet weak var windDirectionUILabel_5: UILabel!
  
  var forecast: Forecast? = .None
  
  func configure(forecast: Forecast) {
    
    self.forecast = forecast
  }
}
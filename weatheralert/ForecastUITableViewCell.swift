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
  
  @IBOutlet weak var forecastContainerUIView_1: UIView!
  @IBOutlet weak var forecastContainerUIView_2: UIView!
  @IBOutlet weak var forecastContainerUIView_3: UIView!
  @IBOutlet weak var forecastContainerUIView_4: UIView!
  @IBOutlet weak var forecastContainerUIView_5: UIView!
  
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
  
  var forecasts: [Forecast] = []
  
  func configure(forecasts: [Forecast]) {
    
    self.forecasts = forecasts
  }
  
  //  MARK: - Programmatic UI Effects
  
  func updateBorderViewCornerRadius () {
    
    borderUIView.layer.cornerRadius = 10.0
    borderUIView.layer.borderColor = UIColor.blackColor().CGColor
    borderUIView.layer.borderWidth = 1.8
    borderUIView.clipsToBounds = true
  }
  
  // Fastest recordord windspeed is 113 metres/sec
  // source: https://en.wikipedia.org/wiki/Wind_speed
  func adjustWindArrowSize(windSpeed: Float) {
    
    // desired size to be between 11 and 44
//    let constant = 11.0 + (33.0 * windSpeed / 113.0)
//    
//    windArrowHeightConstraint.constant = CGFloat(constant)
  }
  
  func adjustWindArrowDirection(windDirection: Float) {
//    let radians: CGFloat = CGFloat(windDirection) / 180.0 * CGFloat(M_PI)
//    
//    let t = CGAffineTransformMakeRotation(radians);
//    windArrowUIImageView.transform = t
  }

  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    updateBorderViewCornerRadius()
  }
  
}
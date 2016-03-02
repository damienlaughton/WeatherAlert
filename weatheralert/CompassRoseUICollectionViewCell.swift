//
//  CompassRoseUICollectionViewCell.swift
//  weatheralert
//
//  Created by Damien Laughton on 02/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class CompassRoseUICollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var windArrowUIImageView: UIImageView!
  @IBOutlet weak var windArrowHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var windSpeedUILabel: UILabel!
  @IBOutlet weak var windDirectionUILabel: UILabel!
  @IBOutlet weak var timeUILabel: UILabel!

  var forecast: Forecast? = .None
  
  func configure(forecast: Forecast) {
    
    self.forecast = forecast
    
    windSpeedUILabel.text = "\(forecast.windSpeed) m/sec"
    
    windDirectionUILabel.text = "\(forecast.windDirection)°"
    
//    let formatter: NSDateFormatter = NSDateFormatter()
//      formatter.dateFormat = "HH:mm"
//    
//    let timeText = formatter.stringFromDate(forecast.dateOfForecast)
//      timeUILabel.text = timeText
    
    adjustWindArrowSize(forecast.windSpeed)
    
    adjustWindArrowDirection(forecast.windDirection)
  }
  
  // Fastest recordord windspeed is 113 metres/sec
  // source: https://en.wikipedia.org/wiki/Wind_speed
  func adjustWindArrowSize(windSpeed: Float) {
    
    // desired size to be between 11 and 44
    let constant = 11.0 + (33.0 * windSpeed / 113.0)
    
    windArrowHeightConstraint.constant = CGFloat(constant)
  }
  
  func adjustWindArrowDirection(windDirection: Float) {
    let radians: CGFloat = CGFloat(windDirection) / 180.0 * CGFloat(M_PI)
    
    let t = CGAffineTransformMakeRotation(radians);
    windArrowUIImageView.transform = t
  }


}

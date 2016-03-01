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
  
  @IBOutlet weak var borderUIView: UIView!
  @IBOutlet weak var windArrowUIImageView: UIImageView!
  @IBOutlet weak var windArrowHeightConstraint: NSLayoutConstraint!

  @IBOutlet weak var nameUILabel: UILabel!
  @IBOutlet weak var windUILabel: UILabel!

  var location: Location? = .None
  
  func configure(location: Location) {
  
    self.location = location
    
    nameUILabel.text = "  \(location.name) (\(location.country))"
    
    windUILabel.text = "   \(location.windSpeed) metres/sec \(location.windDirection)° azimuth"
    
    adjustWindArrowSize(location.windSpeed)
    
    adjustWindArrowDirection(location.windDirection)
  }
  
//  MARK: - Programmatic UI Effects
  
  func updateProfileImageViewCornerRadius () {
  
    borderUIView.layer.cornerRadius = 10.0
    borderUIView.layer.borderColor = UIColor.blackColor().CGColor
    borderUIView.layer.borderWidth = 1.8
    borderUIView.clipsToBounds = true
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
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    updateProfileImageViewCornerRadius()
  }
  
}
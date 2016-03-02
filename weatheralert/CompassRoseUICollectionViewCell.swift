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
  }

}

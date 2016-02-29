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
  
  var location: Location? = .None
  
  func configure(location: Location) {
    self.location = location
  }
  
//  MARK: - Programmatic UI Effects
  
  func updateProfileImageViewCornerRadius () {
  
//    view.backgroundColor = UIColor.whiteColor()
    borderUIView.layer.cornerRadius = 10.0
    borderUIView.layer.borderColor = UIColor.blackColor().CGColor
    borderUIView.layer.borderWidth = 1.8
    borderUIView.clipsToBounds = true
  
  

  }
  
  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    updateProfileImageViewCornerRadius()
  }
  
}
//
//  ForecastUITableViewCell.swift
//  weatheralert
//
//  Created by Damien Laughton on 02/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation
import UIKit

class ForecastUITableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

  @IBOutlet weak var borderUIView: UIView!
  @IBOutlet weak var dateUILabel: UILabel!
  
  var forecasts: [Forecast] = []
  
  func configure(forecasts: [Forecast]) {
    
    self.forecasts = forecasts
    
    let formatter: NSDateFormatter = NSDateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    
    if forecasts.count > 0 {
    
      let timeText = formatter.stringFromDate(forecasts[0].dateOfForecast)
      dateUILabel.text = timeText
      } else {
      
    }
  }
  
  //  MARK: - Programmatic UI Effects
  
  func updateBorderViewCornerRadius () {
    
    borderUIView.layer.cornerRadius = 10.0
    borderUIView.layer.borderColor = UIColor.blackColor().CGColor
    borderUIView.layer.borderWidth = 1.8
    borderUIView.clipsToBounds = true
  }

  override func drawRect(rect: CGRect) {
    super.drawRect(rect)
    
    updateBorderViewCornerRadius()
  }
  
  //  MARK:- UICollectionViewDataSource Method(s)
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    let numberOfItemsInSection = forecasts.count
    
    return numberOfItemsInSection
  }
  
  func forecast (indexPath: NSIndexPath) -> Forecast? {
    var forecast: Forecast? = .None
    
    if indexPath.row < forecasts.count {
      forecast = forecasts[indexPath.row]
    } else {
      
    }
    
    return forecast
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CompassRoseUICollectionViewCell", forIndexPath: indexPath) as! CompassRoseUICollectionViewCell

    if let forecast = forecast(indexPath) {
      cell.configure(forecast)
    }
        
    return cell
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
}
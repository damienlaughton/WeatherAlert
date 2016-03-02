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
    let forecast : Forecast? = forecasts[indexPath.row]
    
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
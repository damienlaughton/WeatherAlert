//
//  LocationDetailViewController.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class LocationDetailViewController: RootViewController {
  
  @IBOutlet weak var detailsUITableView: UITableView!
  
  var selectedLocation: Location? = .None
  var forecasts: [Forecast] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    retrieveForecast()
  }
  
  func retrieveForecast () {
    
  }
  
  // MARK: - UITableViewDataSource Method(s)
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    var numberOfRowsInSection: Int = 1
    
    if section == 2 {
      numberOfRowsInSection = forecasts.count
    }
    
    return numberOfRowsInSection
  }
  
  func location(indexPath: NSIndexPath) -> Location? {
    var location : Location? = .None
    
    if indexPath.section == 1 {
      location = selectedLocation
    }
    
    return location
  }
  
  func forecast(indexPath: NSIndexPath) -> Forecast? {
    var forecast : Forecast? = .None
    
    if indexPath.section == 2 {
      forecast = forecasts[indexPath.row]
    }
    
    return forecast
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    let heightForRowAtIndexPath: CGFloat = 54.0
    
    return heightForRowAtIndexPath
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
    if indexPath.section == 1 {
    
      var cell = tableView.dequeueReusableCellWithIdentifier("LocationUITabelViewCell") as! LocationUITabelViewCell!
      
      if (.None == cell) {
        tableView.registerClass(LocationUITabelViewCell.classForCoder(), forCellReuseIdentifier: "LocationUITabelViewCell")
        
        cell = LocationUITabelViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "LocationUITabelViewCell")
      }
      
      if let location = location(indexPath) {
        cell.configure(location)
      }
      
      return cell
    }
    
    if indexPath.section == 2 {
      
      var cell = tableView.dequeueReusableCellWithIdentifier("ForecastUITableViewCell") as! ForecastUITableViewCell!
      
      if (.None == cell) {
        tableView.registerClass(ForecastUITableViewCell.classForCoder(), forCellReuseIdentifier: "ForecastUITableViewCell")
        
        cell = ForecastUITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ForecastUITableViewCell")
      }
      
      if let forecast = forecast(indexPath) {
        cell.configure(forecast)
      }
      
      return cell
    }
    
    return UITableViewCell()
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
    
    }
}

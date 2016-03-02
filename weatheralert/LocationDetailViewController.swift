//
//  LocationDetailViewController.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class LocationDetailViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var detailsUITableView: UITableView!
  
  var selectedLocation: Location? = .None
  var forecasts: [Forecast] = []
  
  var dailyForecasts: [[Forecast]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    retrieveForecast()
  }
  
  func retrieveForecast () {
    var existingForecastManagedObjects: [ForecastManagedObject] = []
  
    if let location = selectedLocation {
      existingForecastManagedObjects = retrieveForecasts(location: location)
    }
    
    for existingForecastManagedObject in existingForecastManagedObjects {
      let forecast = Forecast(forecastManagedObject: existingForecastManagedObject)
      
      self.forecasts.append(forecast)
    }
    
    apportionDailyForecasts()
    
    self.performSelectorOnMainThread("animateReloadOfTableData", withObject: .None, waitUntilDone: false)
    
    if self.forecasts.count == 0 || anyForecasteHasBeenModifiedMoreThanTenMinutesAgo() {
      updateLatestForecast()
    }
  }
  
  func apportionDailyForecasts () {
    dailyForecasts = []
    
    if forecasts.count > 0 {
    
      forecasts.sortInPlace{ (lhs: Forecast, rhs: Forecast) -> Bool in
        return lhs.dateOfForecast.compare(rhs.dateOfForecast) == .OrderedAscending
      }

    
      var nextForecasts: [Forecast] = []
      
      var dateNextForecasts = forecasts[0].dateOfForecast
      
      for forecast in forecasts {
      
        let forecastDate = NSCalendar.currentCalendar().startOfDayForDate(forecast.dateOfForecast)
        let dateNextForecastsDate = NSCalendar.currentCalendar().startOfDayForDate(dateNextForecasts)
      
        if forecastDate.compare(dateNextForecastsDate) == .OrderedSame {
          nextForecasts.append(forecast)
        } else {
          dateNextForecasts = forecast.dateOfForecast
          dailyForecasts.append(nextForecasts)
          nextForecasts = []
          nextForecasts.append(forecast)
        }
      }
    }
  }
  
  func anyForecasteHasBeenModifiedMoreThanTenMinutesAgo () -> Bool {
    
    var anyForecasteHasBeenModifiedMoreThanTenMinutesAgo = false
    
    let tenMinutesAgo = NSDate().dateByAddingTimeInterval(-1 * 10 * 60)
    
    for forecast in self.forecasts {
      if forecast.timestamp.compare(tenMinutesAgo) == .OrderedAscending {
        anyForecasteHasBeenModifiedMoreThanTenMinutesAgo = true
        break
      }
    }
    
    return anyForecasteHasBeenModifiedMoreThanTenMinutesAgo
  }
  
  // MARK: - UITableViewDataSource Method(s)
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    var numberOfRowsInSection: Int = 1
    
    if section == 1 {
      numberOfRowsInSection = dailyForecasts.count
    }
    
    return numberOfRowsInSection
  }
  
  func location(indexPath: NSIndexPath) -> Location? {
    var location : Location? = .None
    
    if indexPath.section == 0 {
      location = selectedLocation
    }
    
    return location
  }
  
  func dailyForecast(indexPath: NSIndexPath) -> [Forecast]? {
    var dailyForecast : [Forecast] = []
    
    if indexPath.section == 1 {
      dailyForecast = dailyForecasts[indexPath.row]
    }
    
    return dailyForecast
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    var heightForRowAtIndexPath: CGFloat = 54.0
    
    if indexPath.section == 1 {
      heightForRowAtIndexPath = 104.0
    }
    
    return heightForRowAtIndexPath
  }
  
  
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
    if indexPath.section == 0 {
    
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
    
    if indexPath.section == 1 {
      
      var cell = tableView.dequeueReusableCellWithIdentifier("ForecastUITableViewCell") as! ForecastUITableViewCell!
      
      if (.None == cell) {
        tableView.registerClass(ForecastUITableViewCell.classForCoder(), forCellReuseIdentifier: "ForecastUITableViewCell")
        
        cell = ForecastUITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "ForecastUITableViewCell")
      }
      
      if let dailyForecast = dailyForecast(indexPath) {
        cell.configure(dailyForecast)
      }
      
      return cell
    }
    
    return UITableViewCell()
  }
  
  // MARK: - UITableViewDelegate Method(s)
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let heightForHeaderInSection: CGFloat = 21.0
    
    return heightForHeaderInSection
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let viewForHeaderInSection: UILabel = UILabel()
    
    viewForHeaderInSection.font = UIFont(name: "Futura-CondensedMedium", size: 16.0)
    
    if section == 0 {
      viewForHeaderInSection.text = "  CURRENT WEATHER"
    }

    if section == 1 {
      viewForHeaderInSection.text = "  FORECASTS"
    }
    
    return viewForHeaderInSection
  }
  
  //  MARK: - Animation(s)
  
  func animateReloadOfTableData () {
    
    UIView.transitionWithView(self.detailsUITableView,
      duration: 0.5,
      options: UIViewAnimationOptions.TransitionCrossDissolve,
      animations: {
        
        self.detailsUITableView.reloadData()
        
      },
      completion: { finished in
        
    })
  }
  
  //  MARK: - API
  
  func updateLatestForecast() {
    
    if let location = selectedLocation {
    
      
      
      self.forecasts = []
      let apiForecast = APIForecast()
      
      if location.locationId != "0" {
        
        apiForecast.fiveDayThreeHour(cityId: location.locationId, completion: {(resultObject, status) -> () in
          
          if let statusCode = Int(status) {
            switch statusCode {
            case 200:
              if let dictionary = resultObject as? NSDictionary {
                
                if let list = dictionary.objectForKey("list") as? NSArray {
 
                  self.deletePreviousForecasts(location: location)
                    
                  for possibleForecastDictionary in list {
                    
                    if let forecastDictionary = possibleForecastDictionary as? NSDictionary {
                      
                      let newForecast = Forecast(forecastDictionary: forecastDictionary)
                      
                      self.persistNewForecast(location: location, newForecast: newForecast)
                      
                    }
                    
                  }
                }
              }
              
              self.retrieveForecast()
              
              break
            default:
              //A non 200 code implies an error
              break
            }
          }
          
        })
      
      } else {
        apiForecast.fiveDayThreeHour(cityName: location.name, country: location.country, completion: {(resultObject, status) -> () in
          
          if let statusCode = Int(status) {
            switch statusCode {
            case 200:
              if let dictionary = resultObject as? NSDictionary {
                
                if let list = dictionary.objectForKey("list") as? NSArray {
                  
                  self.deletePreviousForecasts(location: location)
                  
                  for possibleForecastDictionary in list {
                    
                    if let forecastDictionary = possibleForecastDictionary as? NSDictionary {
                      
                      let newForecast = Forecast(forecastDictionary: forecastDictionary)
                      
                      self.persistNewForecast(location: location, newForecast: newForecast)
                      
                    }
                    
                  }
                }
              }
              
              self.retrieveForecast()
              
              break
            default:
              //A non 200 code implies an error
              break
            }
          }
          
        })
      }
    }
  }


  
}

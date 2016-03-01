//
//  FavouriteLocationsViewController.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class FavouriteLocationsViewController: RootViewController {
  
  @IBOutlet weak var locationsUITableView: UITableView!
  @IBOutlet weak var titleUILabel: UILabel!
  @IBOutlet weak var addButtonTrailingNSLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var launchCopyUIImageView: UIImageView!
  
  var selectedLocation: Location? = .None
  
  var locations: [Location] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    updateLatestWeather()
    
    openingAnimationSequence()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITableViewDataSource Method(s)
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let numberOfRowsInSection: Int = locations.count
    
    return numberOfRowsInSection
  }
  
  func location(indexPath: NSIndexPath) -> Location? {
    var location : Location? = .None

    if indexPath.row < locations.count {
      location = locations[indexPath.row]
    }

    return location
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    let heightForRowAtIndexPath: CGFloat = 54.0
    
    return heightForRowAtIndexPath
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCellWithIdentifier("LocationUITabelViewCell") as! LocationUITabelViewCell!
    
    if (nil == cell) {
      tableView.registerClass(LocationUITabelViewCell.classForCoder(), forCellReuseIdentifier: "LocationUITabelViewCell")
      
      cell = LocationUITabelViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "LocationUITabelViewCell")
    }
    
    if let location = location(indexPath) {
      cell.configure(location)
    }
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
    
    if let location = location(indexPath) {
      selectedLocation = location
      
      performSegueWithIdentifier("FavouriteLocationsSegueLocationDetail", sender: self)
    }
  }
  
  //  MARK: - Animation(s)
  
  func openingAnimationSequence() {
    
    animateLaunchReveal(duration: 0.4, delay: 1.0, completionHandler:{AnimationCompletionHandler in
      self.animateAddButton(offset:0.0, duration:0.25, delay:0.5)
    })
  }
  
  func animateReloadOfTableData () {
    
    UIView.transitionWithView(self.locationsUITableView,
      duration: 0.5,
      options: UIViewAnimationOptions.TransitionCrossDissolve,
      animations: {
        
        self.locationsUITableView.reloadData()
        
      },
      completion: { finished in
        
    })
    
  }
  
  
  func animateAddButton(offset newOffset: CGFloat, duration:NSTimeInterval, delay: NSTimeInterval, completionHandler:AnimationCompletionHandler = {}) {
    
    addButtonTrailingNSLayoutConstraint.constant = newOffset
    
    UIView.animateWithDuration(duration, delay: delay, options: .CurveEaseInOut, animations: {
      
      self.view.layoutIfNeeded()
      
      }, completion: { finished in
        
        completionHandler()
    })
  }
  
  func animateLaunchReveal(duration duration:NSTimeInterval, delay: NSTimeInterval, completionHandler:AnimationCompletionHandler = {}) {
    
    UIView.animateWithDuration(duration, delay: delay, options: .CurveEaseInOut, animations: {
      
      self.launchCopyUIImageView.alpha = 0.0
      
      }, completion: { finished in
        
        self.launchCopyUIImageView.hidden = true
        
        completionHandler()
    })
  }
  
  //  MARK: - IBAction(s)
  
  @IBAction func addLocation(sender: UIButton) {
    animateAddButton(offset:-6.0, duration:0.05, delay:0.0, completionHandler:{AnimationCompletionHandler in
      self.animateAddButton(offset:0.0, duration:0.1, delay:0.0, completionHandler:{AnimationCompletionHandler in
        
        //        add location here
        
        self.performSegueWithIdentifier("FavouriteLocationsSegueAddLocation", sender: self)
        
      })
    })
  }
  
  //  MARK: - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "FavouriteLocationsSegueLocationDetail" {
      if let location = selectedLocation {
        
        let vc = segue.destinationViewController
        
        if (vc .isKindOfClass(LocationDetailViewController)) {
          
          let rvc = vc as! LocationDetailViewController
          rvc.selectedLocation = location
          
        }
        
      }
    }
    
  }
  
//  MARK: - API

  func updateLatestWeather() {
    let apiWeather = APIWeather()
    
    apiWeather.weather(cities: ["2643743"], completion: {(resultObject, status) -> () in
    
//    apiWeather.weather(cityName: "London", country: "uk", completion: {(resultObject, status) -> () in
    
      if let statusCode = Int(status) {
      switch statusCode {
        case 200:
        
          if let weatherDictionary = resultObject as? NSDictionary {
        
            let location = Location(weatherDictionary: weatherDictionary)
            
            self.locations.append(location)
            
            self.performSelectorOnMainThread("animateReloadOfTableData", withObject: nil, waitUntilDone: false)
          }
        
        break
        
        default:
        //A non 200 code implies an error
        

        

        
        break
        }
      }
      
    })
  }
}





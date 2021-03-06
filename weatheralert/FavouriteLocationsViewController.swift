//
//  FavouriteLocationsViewController.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class FavouriteLocationsViewController: RootViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var locationsUITableView: UITableView!
  @IBOutlet weak var titleUILabel: UILabel!
  @IBOutlet weak var addButtonTrailingNSLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var launchCopyUIImageView: UIImageView!
  @IBOutlet weak var zeroLocationsMessageView: UIView!
  
  var deleteLocationIndexPath: NSIndexPath? = .None
  
  var locations: [Location] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    openingAnimationSequence()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidDisappear(animated)
    
    retrieveExistingWeather()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func retrieveExistingWeather() {
    let existingLocationManagedObjects = retrieveFavouriteLocations()
    
    self.locations = []
    
    for existingLocationManagedObject in existingLocationManagedObjects {
      let location = Location(locationManagedObject: existingLocationManagedObject)
      
      self.locations.append(location)
    }
    
    self.performSelectorOnMainThread("animateReloadOfTableData", withObject: .None, waitUntilDone: false)
    
    checkForZeroLocations()
    
    if anyFavouriteHasBeenModifiedMoreThanTenMinutesAgo() {
    
      updateLatestWeather()
    }
  }
  
  func checkForZeroLocations () {
    if self.locations.count == 0 {
      animateZeroLocationsMessage(duration: 0.3, delay: 1.0)
    } else {
      zeroLocationsMessageView.alpha = 0.0
    }
  }
  
  func anyFavouriteHasBeenModifiedMoreThanTenMinutesAgo () -> Bool {
  
    var anyFavouriteHasBeenModifiedMoreThanTenMinutesAgo = false
    
    let tenMinutesAgo = NSDate().dateByAddingTimeInterval(-1 * 10 * 60)
    
    for location in self.locations {
      if location.timestamp.compare(tenMinutesAgo) == .OrderedAscending {
        anyFavouriteHasBeenModifiedMoreThanTenMinutesAgo = true
        break
      }
    }
    
    return anyFavouriteHasBeenModifiedMoreThanTenMinutesAgo
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
    
    if (.None == cell) {
      tableView.registerClass(LocationUITabelViewCell.classForCoder(), forCellReuseIdentifier: "LocationUITabelViewCell")
      
      cell = LocationUITabelViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "LocationUITabelViewCell")
    }
    
    if let location = location(indexPath) {
      cell.configure(location)
    }
    
    return cell
  }
  
  // MARK: - UITableViewDelegate Method(s)
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
    
    if let location = location(indexPath) {
      ApplicationManagerSingleton.sharedInstance.selectedLocation = location
      
      performSegueWithIdentifier("FavouriteLocationsSegueLocationDetail", sender: self)
    }
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    deleteLocationIndexPath = indexPath
      if let location = location(indexPath) {
        confirmDelete(location.name)
      }
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
  
  func animateZeroLocationsMessage(duration duration:NSTimeInterval, delay: NSTimeInterval, completionHandler:AnimationCompletionHandler = {}) {
    
    self.zeroLocationsMessageView.alpha = 0.0
    
    UIView.animateWithDuration(duration, delay: delay, options: .CurveEaseInOut, animations: {
      
      self.zeroLocationsMessageView.alpha = 1.0
      
      }, completion: { finished in
        
        completionHandler()
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
      if let location = ApplicationManagerSingleton.sharedInstance.selectedLocation {
        
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
  
    if locations.count > 0 {
    
    var arrayOfLocationIds:[String] = []
    var listOfLocationIds: String = ""
    
      for location in locations {
        if "0" != location.locationId {
          arrayOfLocationIds.append(location.locationId)
          listOfLocationIds = listOfLocationIds + location.locationId + ","
        }
      }
      
      listOfLocationIds = String(listOfLocationIds.characters.dropLast())
  
      let apiWeather = APIWeather()
      
      apiWeather.weatherGroup(cities: listOfLocationIds, completion: {(resultObject, status) -> () in
      
      if let statusCode = Int(status) {
      switch statusCode {
        case 200:
          if let dictionary = resultObject as? NSDictionary {
          
            if let list = dictionary.objectForKey("list") as? NSArray {
          
              for possibleWeatherDictionary in list {
          
                if let weatherDictionary = possibleWeatherDictionary as? NSDictionary {
                  
                  let newLocation = Location(weatherDictionary: weatherDictionary)
                  
                  if let existingLocationManagedObject = self.retrieveExistingLocation(newLocation.locationId) {
                    
                    self.updateLocation(existingLocationManagedObject, newLocation: newLocation)
                    
                  } else {
                    
                    self.persistNewLocation(newLocation)
                  }
                }
                
              }
            
            }
          }
        
          self.retrieveExistingWeather()
        
        break
        
        default:
        //A non 200 code implies an error
        

        

        
        break
        }
      }
        
      })
    }
  }
  
  // MARK: - Deleting Locations
  
  func confirmDelete(location: String) {
    let alert = UIAlertController(title: "Delete Location", message: "Are you sure you want to delete \(location)?", preferredStyle: .ActionSheet)
    
    let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteLocation)
    let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteLocation)
    
    alert.addAction(DeleteAction)
    alert.addAction(CancelAction)
    
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  func handleDeleteLocation(alertAction: UIAlertAction!) -> Void {
    if let indexPath = deleteLocationIndexPath {
    
      if let locationForDeletion = location(indexPath) {
        deleteLocation(location: locationForDeletion)
        
      }
    
      locationsUITableView.beginUpdates()
      
      locations.removeAtIndex(indexPath.row)

      locationsUITableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      
      deleteLocationIndexPath = .None
      
      locationsUITableView.endUpdates()
    }
    
    checkForZeroLocations()
  }
  
  func cancelDeleteLocation(alertAction: UIAlertAction!) {
    deleteLocationIndexPath = .None
  }
}





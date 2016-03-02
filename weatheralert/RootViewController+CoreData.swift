//
//  RootViewController+CoreData.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation
import CoreData

extension RootViewController {
  
  // MARK: - LocationManagedObject
  
  func retrieveExistingLocation(existingLocationId: String) -> LocationManagedObject? {
    var existingLocation:LocationManagedObject? = .None
    
    var existingLocations:[LocationManagedObject] = []
    
    if let moc = CoreDataManagerSingleton.sharedInstance.mainQManagedObjectContext() {
      
      let fetchRequest = NSFetchRequest(entityName: "LocationManagedObject")
      
      do {
        let results =
        try moc.executeFetchRequest(fetchRequest)
        existingLocations = results as! [LocationManagedObject]
        
        for location in existingLocations {
          if location.locationId == existingLocationId {
            existingLocation = location
            break
          }
        }
        
      } catch let error as NSError {
        print("Could not fetch \(error), \(error.userInfo)")
      }
    }
    
    return existingLocation
  }
  
  func retrieveFavouriteLocations() -> [LocationManagedObject] {
    var favouriteLocations:[LocationManagedObject] = []
    
    if let moc = CoreDataManagerSingleton.sharedInstance.mainQManagedObjectContext() {
      
      let fetchRequest = NSFetchRequest(entityName: "LocationManagedObject")
      
      do {
        let results =
        try moc.executeFetchRequest(fetchRequest)
        favouriteLocations = results as! [LocationManagedObject]
      } catch let error as NSError {
        print("Could not fetch \(error), \(error.userInfo)")
      }
    }
    
    return favouriteLocations
  }
  
  func persistNewLocation(newLocation: Location) {
    
    if let moc = CoreDataManagerSingleton.sharedInstance.mainQManagedObjectContext() {
      
      if let locationEntity = NSEntityDescription.entityForName("LocationManagedObject", inManagedObjectContext: moc) {
        
        if let newLocationManagedObject = NSManagedObject(entity: locationEntity,
          insertIntoManagedObjectContext: moc) as? LocationManagedObject {
            newLocationManagedObject.name = newLocation.name
            newLocationManagedObject.originalName = newLocation.originalName
            newLocationManagedObject.locationId = newLocation.locationId
            newLocationManagedObject.country = newLocation.country
            newLocationManagedObject.windSpeed = newLocation.windSpeed
            newLocationManagedObject.windDirection = newLocation.windDirection
            newLocationManagedObject.sign()
            
            CoreDataManagerSingleton.sharedInstance.saveAllContexts()
        }
      }
    }
    
  }
  
  func updateLocation(existingLocationManagedObject:LocationManagedObject, newLocation: Location) {
    
    existingLocationManagedObject.name = newLocation.name
    existingLocationManagedObject.locationId = newLocation.locationId
    existingLocationManagedObject.country = newLocation.country
    existingLocationManagedObject.windSpeed = newLocation.windSpeed
    existingLocationManagedObject.windDirection = newLocation.windDirection
    existingLocationManagedObject.sign()
    
    CoreDataManagerSingleton.sharedInstance.saveAllContexts()
    
  }
  
  // MARK: - ForecastManagedObject
  
  func retrieveForecasts(location location: Location) -> [ForecastManagedObject] {
    var forecasts:[ForecastManagedObject] = []
    
    if let locationManagedObject = retrieveExistingLocation(location.locationId) {
      
      if let forecastManagedObjects = locationManagedObject.forecasts {
        forecasts = (forecastManagedObjects.allObjects as? [ForecastManagedObject])!
      }
    }
    
    return forecasts
  }
  
  func deletePreviousForecasts(location location: Location) {
    
    if let moc = CoreDataManagerSingleton.sharedInstance.mainQManagedObjectContext() {
      
      moc.performBlockAndWait {
        
        if let locationManagedObject = self.retrieveExistingLocation(location.locationId) {
          
          let forecastManagedObjects = self.retrieveForecasts(location: location)
          
          for forecastManagedObject in forecastManagedObjects {
            moc.deleteObject(forecastManagedObject)
          }
          
          locationManagedObject.forecasts = .None
        }
        
        CoreDataManagerSingleton.sharedInstance.saveAllContexts()
      }
    }
  }
  
  func persistNewForecast(location location: Location, newForecast: Forecast) {
    
    if let moc = CoreDataManagerSingleton.sharedInstance.mainQManagedObjectContext() {
      
      moc.performBlockAndWait {
      
        if let locationManagedObject = self.retrieveExistingLocation(location.locationId) {
          
          if let forecastEntity = NSEntityDescription.entityForName("ForecastManagedObject", inManagedObjectContext: moc) {
            
            if let newForecastManagedObject = NSManagedObject(entity: forecastEntity,
              insertIntoManagedObjectContext: moc) as? ForecastManagedObject {
                
                newForecastManagedObject.location = locationManagedObject
                newForecastManagedObject.dateOfForecast = newForecast.dateOfForecast
                newForecastManagedObject.windSpeed = newForecast.windSpeed
                newForecastManagedObject.windDirection = newForecast.windDirection
                newForecastManagedObject.sign()
                
                CoreDataManagerSingleton.sharedInstance.saveAllContexts()
            }
          }
        }
      }
    }
  }
  
}

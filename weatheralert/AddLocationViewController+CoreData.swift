//
//  AddLocationViewController+CoreData.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation
import CoreData

extension AddLocationViewController {

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
  
  func persistNewLocation(newLocation: Location) {
    
    if let moc = CoreDataManagerSingleton.sharedInstance.mainQManagedObjectContext() {
      
      if let locationEntity = NSEntityDescription.entityForName("LocationManagedObject", inManagedObjectContext: moc) {
        
        if let newLocationManagedObject = NSManagedObject(entity: locationEntity,
          insertIntoManagedObjectContext: moc) as? LocationManagedObject {
            newLocationManagedObject.name = newLocation.name
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
    
//    if let moc = CoreDataManagerSingleton.sharedInstance.mainQManagedObjectContext() {
    

        

            existingLocationManagedObject.name = newLocation.name
            existingLocationManagedObject.locationId = newLocation.locationId
            existingLocationManagedObject.country = newLocation.country
            existingLocationManagedObject.windSpeed = newLocation.windSpeed
            existingLocationManagedObject.windDirection = newLocation.windDirection
            existingLocationManagedObject.sign()
            
            CoreDataManagerSingleton.sharedInstance.saveAllContexts()
//    }
    
  }
  
}

//
//  FavouriteLocationsViewController+CoreData.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import Foundation
import CoreData

extension FavouriteLocationsViewController {

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

}
//
//  CoreDataManagerSingleton.swift
//  weatheralert
//
//  Created by Damien Laughton on 24/02/2015.
//  Copyright © 2016 Mobilolgy. All rights reserved.
//

import Foundation
import CoreData

@objc class CoreDataManagerSingleton : NSObject {
  class var sharedInstance :CoreDataManagerSingleton {
    struct Singleton {
      static let instance = CoreDataManagerSingleton()
    }
    
    return Singleton.instance
  }
  
  
  // MARK: - Core Data stack
  
  lazy var applicationDocumentsDirectory: NSURL = {
    // The directory the application uses to store the Core Data store file(s).
    
    let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls[urls.count-1]
  }()
  
  lazy var managedObjectModel: NSManagedObjectModel = {
    // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
    
    let modelURL = NSBundle.mainBundle().URLForResource(CORE_DATA_NAME, withExtension: "momd")!
    return NSManagedObjectModel(contentsOfURL: modelURL)!
  }()
  
  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    
    // Create the coordinator and store
    
    var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(CoreDataManagerSingleton.sharedInstance.sqlite_file_name())
    var error: NSError? = nil
    var failureReason = "There was an error creating or loading the application's saved data."
    do {
      try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
    } catch var error1 as NSError {
      error = error1
      coordinator = nil
      // Report any error we got.
      //            let dict = NSMutableDictionary()
      //            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
      //            dict[NSLocalizedFailureReasonErrorKey] = failureReason
      //            dict[NSUnderlyingErrorKey] = error
      
      error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: nil)
      // Replace this with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error \(error), \(error!.userInfo)")
      abort()
    } catch {
      fatalError()
    }
    
    return coordinator
  }()
  
  lazy private var managedObjectContext: NSManagedObjectContext? = {
    
    let coordinator = self.persistentStoreCoordinator
    if coordinator == nil {
      return nil
    }
    
    var mainQmanagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
    
    var parentPrivateQManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
    
    parentPrivateQManagedObjectContext.persistentStoreCoordinator = coordinator
    
    mainQmanagedObjectContext.parentContext = parentPrivateQManagedObjectContext
    
    
    return mainQmanagedObjectContext
  }()
  
  // MARK: - Exposed MOCs
  
  func mainQManagedObjectContext () -> NSManagedObjectContext? {
    return self.managedObjectContext!
  }
  
  func privateQManagedObjectContext () -> NSManagedObjectContext? {
    return self.managedObjectContext?.parentContext
  }
  
  //  MARK: - Save Method(s)
  
  private func save(context: NSManagedObjectContext?) {
    if let moc = context {
    moc.performBlockAndWait {
      var error: NSError? = nil
      if moc.hasChanges {
        do {
          
            try moc.save()
        
        } catch let error1 as NSError {
          error = error1
          // Replace this implementation with code to handle the error appropriately.
          // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
          NSLog("Unresolved error \(error), \(error!.userInfo)")
          abort()
        }
      }
        }
    }
  }
  
  func saveContext(context: NSManagedObjectContext) {
    self.save(context)
  }
  
  func saveMainQContext () {
    self.save(self.mainQManagedObjectContext())
  }
  
  func savePrivateQContext () {
    self.save(self.privateQManagedObjectContext())
  }
  
  func saveAllContexts () {
    self.save(self.mainQManagedObjectContext())
    self.save(self.privateQManagedObjectContext())
  }
  
  
}
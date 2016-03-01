//
//  CoreDataManagerExtension.swift
//  weatheralert
//
//  Created by Damien Laughton on 24/02/2015.
//  Copyright © 2016 Mobilolgy. All rights reserved.
//

import Foundation
import CoreData

let CORE_DATA_NAME = "weatheralert"

enum CoreDataError: ErrorType {
  case RecordNotFound
  case FailedToDelete
}

extension CoreDataManagerSingleton {

  func sqlite_file_name () -> String {
  
    let sqlite_file_name = "\(CORE_DATA_NAME).sqlite"
    
    return sqlite_file_name

  }

  func sqlite_wal_file_name () -> String {
    
    let sqlite_wal_file_name = "\(CORE_DATA_NAME).sqlite-wal"
    
    return sqlite_wal_file_name
    
  }

  func sqlite_shm_file_name () -> String {
    
    let sqlite_shm_file_name = "\(CORE_DATA_NAME).sqlite-shm"
    
    return sqlite_shm_file_name
    
  }
  
  func sqlite_path () -> String {

    let sqlite_path = "\(ApplicationManagerSingleton.sharedInstance.documentsDirectory())/\(self.sqlite_file_name())"
    
    return sqlite_path
  }
  
  func sqlite_wal_path () -> String {
    
    let sqlite_wal_path = "\(ApplicationManagerSingleton.sharedInstance.documentsDirectory())/\(self.sqlite_wal_file_name())"
    
    return sqlite_wal_path
  }
  
  func sqlite_shm_path () -> String {
    
    let sqlite_shm_path = "\(ApplicationManagerSingleton.sharedInstance.documentsDirectory())/\(self.sqlite_shm_file_name())"
    
    return sqlite_shm_path
  }
  
//  MARK: - Initial Vanilla Database

// When the app runs for the first time we want to copy the bundled database to the Documents
// directory on the device

  func configureInitialDatabase () {
    let extantDatabase1: Bool? = NSFileManager.defaultManager().fileExistsAtPath(self.sqlite_path())
    let extantDatabase2: Bool? = NSFileManager.defaultManager().fileExistsAtPath(self.sqlite_wal_path())
    let extantDatabase3: Bool? = NSFileManager.defaultManager().fileExistsAtPath(self.sqlite_shm_path())
    
    if (false == extantDatabase1) || (false == extantDatabase2) || (false == extantDatabase3) {
      self.copyDataBaseFiles()
      
    }
  }
  
  func copyDataBaseFiles () -> Bool {
    
    var allThreeDatabaseFilesCopied: Bool = false
    
    let bundledDatabasePath1: String? = NSBundle.mainBundle().pathForResource(CORE_DATA_NAME, ofType: "sqlite")
    let bundledDatabasePath2: String? = NSBundle.mainBundle().pathForResource(CORE_DATA_NAME, ofType: "sqlite-wal")
    let bundledDatabasePath3: String? = NSBundle.mainBundle().pathForResource(CORE_DATA_NAME, ofType: "sqlite-shm")
    
    if (.None != bundledDatabasePath1) && (.None != bundledDatabasePath2) && (.None != bundledDatabasePath3) {
      
      var error1: NSError? = nil
      var error2: NSError? = nil
      var error3: NSError? = nil
      
      do {
        try NSFileManager.defaultManager().copyItemAtPath(bundledDatabasePath1!, toPath: self.sqlite_path())
      } catch let error as NSError {
        error1 = error
      }
      do {
        try NSFileManager.defaultManager().copyItemAtPath(bundledDatabasePath2!, toPath: self.sqlite_wal_path())
      } catch let error as NSError {
        error2 = error
      }
      do {
        try NSFileManager.defaultManager().copyItemAtPath(bundledDatabasePath3!, toPath: self.sqlite_shm_path())
      } catch let error as NSError {
        error3 = error
      }
      
      if (nil == error1) && (nil == error2) && (nil == error3) {
        allThreeDatabaseFilesCopied = true
      }
      
    }
    
    return allThreeDatabaseFilesCopied
  }

  
}

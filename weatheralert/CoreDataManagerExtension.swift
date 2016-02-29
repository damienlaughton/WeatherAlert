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
  
}

//
//  AddLocationTests.swift
//  weatheralert
//
//  Created by Damien Laughton on 02/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import XCTest
@testable import weatheralert
import CoreData

class AddLocationTests: XCTestCase {

  var viewController: weatheralert.AddLocationViewController!
  var weatherDictionary: NSDictionary!
  
  var newLocation: weatheralert.Location?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AddLocationViewController") as! weatheralert.AddLocationViewController
      
        weatherDictionary = ["name":"ABC","country":"US","id":123456,"speed":2.3,"deg":45]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

  func testMoc () {
    let moc = CoreDataManagerSingleton.sharedInstance.mainQManagedObjectContext()
    XCTAssertNotNil(moc, "Managed Object Context must be valid")
  }
  
  func testLocationCreation () {
    newLocation = weatheralert.Location(weatherDictionary:weatherDictionary)
    
    XCTAssertNotNil(newLocation?.timestamp, "Locations must have a time stamp")
  }
  
  func testAddLocationManagedObject () {
    let location = weatheralert.Location(weatherDictionary:weatherDictionary)
    viewController.persistNewLocation(location)
    CoreDataManagerSingleton.sharedInstance.saveAllContexts()
    let retrievedLocationManagedObject = viewController.retrieveExistingLocation("123456")
    XCTAssertNotNil(retrievedLocationManagedObject, "LocationManagedObject must be persisted")
  }
  
  func testDeleteLocationManagedObject () {
    let location = weatheralert.Location(weatherDictionary:weatherDictionary)
    viewController.deleteLocation(location: location)
    
    let retrievedLocationManagedObject = viewController.retrieveExistingLocation("123456")
    
    XCTAssertNil(retrievedLocationManagedObject, "LocationManagedObject not deleted.")
  }

}

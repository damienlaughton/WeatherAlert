//
//  LocationDetailTests.swift
//  weatheralert
//
//  Created by Damien Laughton on 02/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import XCTest
@testable import weatheralert
import CoreData

class LocationDetailTests: XCTestCase {

  var viewController: weatheralert.LocationDetailViewController!
  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LocationDetailViewController") as! weatheralert.LocationDetailViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }



}

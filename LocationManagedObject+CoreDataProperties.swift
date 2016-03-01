//
//  LocationManagedObject+CoreDataProperties.swift
//  weatheralert
//
//  Created by Damien Laughton on 01/03/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LocationManagedObject {

    @NSManaged var name: String?
    @NSManaged var country: String?
    @NSManaged var locationId: String?
    @NSManaged var windSpeed: NSNumber?
    @NSManaged var windDirection: NSNumber?
}

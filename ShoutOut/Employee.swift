//
//  Employee.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/13/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import Foundation
import CoreData

public class Employee: NSManagedObject, NamedEntity {
    static var entityName: String {
        return "Employee"
    }

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var department: String

    @NSManaged var shoutOuts: NSSet?
}

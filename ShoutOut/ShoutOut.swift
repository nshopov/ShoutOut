//
//  ShoutOut.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/12/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import Foundation
import CoreData


class ShoutOut: NSManagedObject, NamedEntity {
    static var entityName: String {
        return "ShoutOut"
    }





    @NSManaged var from: String?
    @NSManaged var message: String?
    @NSManaged var sentOn: Date?
    @NSManaged var shoutCategory: String
    
    
    @NSManaged var toEmployee: Employee
}

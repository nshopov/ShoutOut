//
//  DataService.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/13/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import Foundation
import CoreData

struct DataService: ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext!


    func seedEmployees() {

        let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)

        do {
            let employeesAlreadySeeded = try self.managedObjectContext.fetch(employeeFetchRequest).count > 0

            if employeesAlreadySeeded == false {
                let employee1 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee1.firstName = "Nikola"
                employee1.lastName  = "Shopov"

                let employee2 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee2.firstName = "James"
                employee2.lastName  = "Shaw"

                let employee3 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee3.firstName = "Marla"
                employee3.lastName  = "Shaw"

                let employee4 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee4.firstName = "Ivanna"
                employee4.lastName  = "Kalkova"

                let employee5 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee5.firstName = "Many"
                employee5.lastName  = "Johnes"

                let employee6 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee6.firstName = "Kastubph"
                employee6.lastName  = "Chatae"


                do {
                    try self.managedObjectContext.save()
                } catch  {
                    print("something went wrong! \(error)")
                    self.managedObjectContext.rollback()
                }

            }

        } catch  {
            
        }



    }
}

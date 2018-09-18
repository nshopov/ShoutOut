 //
//  DataService.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/13/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import Foundation
import CoreData

enum Department {
    static let InformationTechnogy = "Information Technoglogy"
    static let Legal = "Legal"
    static let Accounting = "Accounting"
}

struct DataService: ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext!

    

    func seedEmployees() {

        let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)

        do {
            let employees = try self.managedObjectContext.fetch(employeeFetchRequest)
            let employeesAlreadySeeded = employees.count > 0

            if employeesAlreadySeeded == false {
                let employee1 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee1.firstName = "Nikola"
                employee1.lastName  = "Shopov"
                employee1.department = Department.Accounting

                let employee2 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee2.firstName = "James"
                employee2.lastName  = "Shaw"
                employee2.department = Department.InformationTechnogy

                let employee3 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee3.firstName = "Marla"
                employee3.lastName  = "Shaw"
                employee3.department = Department.InformationTechnogy

                let employee4 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee4.firstName = "Ivanna"
                employee4.lastName  = "Kalkova"
                employee4.department = Department.Legal

                let employee5 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee5.firstName = "Many"
                employee5.lastName  = "Johnes"
                employee5.department = Department.Legal

                let employee6 = NSEntityDescription.insertNewObject(forEntityName: Employee.entityName, into: self.managedObjectContext) as! Employee

                employee6.firstName = "Kastubph"
                employee6.lastName  = "Chatae"
                employee6.department = Department.Accounting

            } else {
                for employee in employees  {
                    if employee.department == "Unknown department" {
                        switch employee.lastName {
                        case "Shaw":
                            employee.department = Department.InformationTechnogy
                        case "Chatae", "Shopov":
                            employee.department = Department.Accounting
                        case "Kalkova", "Jones":
                            employee.department = Department.Legal
                        default:
                            break
                        }
                    }
                }
            }
            
            do {
                try self.managedObjectContext.save()
            } catch  {
                print("something went wrong! \(error)")
                self.managedObjectContext.rollback()
            }

        } catch  {
            
        }



    }
}

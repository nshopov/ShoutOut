//
//  SaveDataAndDelete.swift
//  ShoutOutTests
//
//  Created by Nikola Shopov on 9/13/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import XCTest
import CoreData
 
@testable import ShoutOut

class SaveDataAndDelete: XCTestCase {
    var inMemoryContext: NSManagedObjectContext!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let dataStack = CoreDataStack()
        self.inMemoryContext = dataStack.creatInMemboryContext()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFetchAllEmployees() {
        let dataStack = CoreDataStack()
        let inMemroyContext = dataStack.creatInMemboryContext()

        let dataService = DataService(managedObjectContext: inMemroyContext)
        dataService.seedEmployees()

        let employeesFetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)
        do {
            let employees = try inMemroyContext.fetch(employeesFetchRequest)
            print(employees)
        } catch  {
            print("Something went wrong! \(error)")
        }
    }

    func testFilterShoutOuts()  {
        let dataStack = CoreDataStack()
        let inMemroyContext = dataStack.creatInMemboryContext()

        let dataService = DataService(managedObjectContext: inMemroyContext)
        dataService.seedEmployees()

        let shoutOutFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
        let shoutOutCategoryPredicate = NSPredicate(format: "%K == %@", #keyPath(ShoutOut.shoutCategory), "Well Done!")

        shoutOutFetchRequest.predicate = shoutOutCategoryPredicate

        do {
            let filteredShoutOuts = try inMemroyContext.fetch(shoutOutFetchRequest)
            print(filteredShoutOuts)
        } catch  {
            print("Something went wrong! \(error)")
        }
    }

    func testSortShoutOuts() {
        let shoutOutFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)

        do {
            let shoutOuts =  try inMemoryContext.fetch(shoutOutFetchRequest)
            print("--------- UNSORTED SHOUTOUTS ------------")
            print(shoutOuts)
        } catch _ {}

        let shoutOutCategorySortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.shoutCategory), ascending: true)
        let lastNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.lastName), ascending: true)
        let firstNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.firstName), ascending: true)

        shoutOutFetchRequest.sortDescriptors = [shoutOutCategorySortDescriptor, firstNameSortDescriptor, lastNameSortDescriptor]

        do {
            let shoutOuts =  try inMemoryContext.fetch(shoutOutFetchRequest)
            print("--------- SORTED SHOUTOUTS ------------")
            print(shoutOuts)
        } catch _ {}
    }
}

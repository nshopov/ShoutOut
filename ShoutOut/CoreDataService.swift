//
//  CoreDataService.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/21/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    var listItems: [ShoutOut] { get }
    init(with context: NSManagedObjectContext)

    func fetchShoutOuts()
}

class CoreDataService: CoreDataServiceProtocol,
                       ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext!
    var listItems: [ShoutOut] = [ShoutOut]()
    var fetchedResultsController: NSFetchedResultsController<ShoutOut>!

    required init(with context: NSManagedObjectContext) {
        self.managedObjectContext = context
        self.configureFetchResultsController()
    }

    func configureFetchResultsController() {
        let shoutOutFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
        let lastNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.lastName), ascending: true)
        let departmentSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.department), ascending: true)
        let firstNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.firstName), ascending: true)
        shoutOutFetchRequest.sortDescriptors = [departmentSortDescriptor, lastNameSortDescriptor, firstNameSortDescriptor]

        self.fetchedResultsController = NSFetchedResultsController<ShoutOut>(fetchRequest: shoutOutFetchRequest,
                                                                             managedObjectContext: self.managedObjectContext,
                                                                             sectionNameKeyPath: #keyPath(ShoutOut.toEmployee.department),
                                                                             cacheName: nil)
    }

    func fetchShoutOuts() {
        do {
            try self.fetchedResultsController.performFetch()
            self.listItems = fetchedResultsController.fetchedObjects!
            print(self.listItems)
        } catch  {
            fatalError("fetch results from controller not OK")
        }
    }

}

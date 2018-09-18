//
//  CoreDataStack.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/11/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataStack {
    func createMainContext(completion: @escaping (NSPersistentContainer)->Void) {
        let container = NSPersistentContainer(name: "ShoutOut")
        container.loadPersistentStores {
            persistentStoreDescription, error in
            guard error == nil else {
                fatalError("Failed to load store \(String(describing: error))")
            }
            
            DispatchQueue.main.async {
                completion(container)
            }
        }
    }

    func creatInMemboryContext() -> NSManagedObjectContext {
        let modelURL = Bundle.main.url(forResource: "ShoutOut", withExtension: "momd")
        guard let model = NSManagedObjectModel(contentsOf: modelURL!) else {
            fatalError("model not right!")
        }

        let persistanceCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try! persistanceCoordinator.addPersistentStore(ofType: NSInMemoryStoreType,
                                                       configurationName: nil,
                                                       at: nil,
                                                       options: nil)

        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistanceCoordinator
        return context
    }
}


extension URL {
    static var documentsURL: URL{
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}

protocol ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext! {get set}
}

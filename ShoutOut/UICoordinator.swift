//
//  UICoordinator.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/21/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import UIKit
import CoreData

class UICoordinator {
    var managedObjectContext:  NSManagedObjectContext!

    init(with context: NSManagedObjectContext){
        self.managedObjectContext = context
    }

    func presentRxTableViewScreen(on window: UIWindow?) {
        let storyBoard = window?.rootViewController?.storyboard
        guard let rootVC = storyBoard?.instantiateViewController(withIdentifier: "RootViewController") else {
            fatalError("Could not instantiate root view controller!")
        }

        window?.rootViewController = rootVC

        let navController = window?.rootViewController as! UINavigationController
        let fistVC = navController.viewControllers[0]
        let firstViewController = fistVC as! ShoutOutDraftsRxViewController

        firstViewController.viewModel = ShoutOutDraftsViewModel(with: self.managedObjectContext,
                                                                with: ShoutOutRouter())
    }

    func presentTableViewScreen(on window: UIWindow?) {
        let storyBoard = window?.rootViewController?.storyboard
        guard let rootVC = storyBoard?.instantiateViewController(withIdentifier: "RootViewController") else {
            fatalError("Could not instantiate root view controller!")
        }

        window?.rootViewController = rootVC

        let navController = window?.rootViewController as! UINavigationController
        let fistVC = navController.viewControllers[0]
        let firstViewController = fistVC as! ShoutOutDraftsViewController
        firstViewController.managedObjectContext = self.managedObjectContext
    }
}

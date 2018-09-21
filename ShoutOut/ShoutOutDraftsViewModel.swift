//
//  ShoutOutViewModel.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/20/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreData

protocol ShoutOutDraftsViewModelProtocol: MVVMModel {
    var shoutOutList: Variable<[ShoutOut]>{ get }
    init(with context: NSManagedObjectContext, with router: MVVMRouter)
    func fetchShoutOuts()
}

class ShoutOutDraftsViewModel: ShoutOutDraftsViewModelProtocol {
    required init(with context: NSManagedObjectContext, with router: MVVMRouter) {
        self.router = router
        self.coredataService = CoreDataService(with: context)
    }


    var coredataService: CoreDataServiceProtocol!
    var shoutOutList: Variable<[ShoutOut]> = Variable<[ShoutOut]>([])
    var router: MVVMRouter

    func fetchShoutOuts() {
        self.coredataService.fetchShoutOuts()
        self.shoutOutList.value = coredataService.listItems
    }

    init(with router: MVVMRouter){
        self.router = router

        self.setupBindings()
    }

    fileprivate func setupBindings(){
        self.shoutOutList.value = coredataService.listItems
    }
}

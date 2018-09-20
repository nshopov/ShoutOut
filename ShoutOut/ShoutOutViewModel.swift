//
//  ShoutOutViewModel.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/20/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import Foundation

class ShoutOutViewModel: MVVMModel {
    var router: MVVMRouter

    init(with router: MVVMRouter){
        self.router = router
    }

}

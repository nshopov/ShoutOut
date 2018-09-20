//
//  MVVMViewController.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/20/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

protocol MVVMViewController {
    associatedtype ViewModelType

    var viewModel: ViewModelType! {get set}
}

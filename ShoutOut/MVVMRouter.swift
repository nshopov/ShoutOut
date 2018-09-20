//
//  MVVMRouter.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/20/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//
import UIKit
import Foundation

protocol MVVMRouter {
    var baseViewController: UIViewController? {get set}

    func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?)

    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?)

    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?)
}


extension MVVMRouter {
    func present(on baseVC: UIViewController){
        self.present(on: baseVC, animated: true, context: nil, completion: nil)
    }

    func enqueueRoute(with context: Any?) {
        self.enqueueRoute(with: context, animated: true, completion: nil)
    }

    func enqueueRoute(with context: Any?, completion: ((Bool) -> Void)?) {
        self.enqueueRoute(with: context, animated: true, completion: completion)
    }
}

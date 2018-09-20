//
//  ShoutOutDraftsRxViewController.swift
//  ShoutOut
//
//  Created by Nikola Shopov on 9/20/18.
//  Copyright © 2018 pluralsight. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class ShoutOutDraftsRxViewController: UIViewController, MVVMViewController {
    // MARK: -- MVVVMViewController members implementation
    var viewModel: ShoutOutViewModel!

    // MARK: -- Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: -- RX Maintenance
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

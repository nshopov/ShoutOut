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
import CoreData

class ShoutOutDraftsRxViewController: UIViewController,
                                      MVVMViewController {
     

    // MARK: -- MVVVMViewController members implementation
    var viewModel: ShoutOutDraftsViewModelProtocol!

    // MARK: -- Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: -- RX Maintenance
    private let disposeBag = DisposeBag()

    // MARK: -- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup table view.
        self.viewModel.shoutOutList.asObservable().bind(to:tableView.rx.items) { (tableView, row, shoutOut) in
            let cell: UITableViewCell
            let reuseId = "subtitleCell"
            if let reusedCell = tableView.dequeueReusableCell(withIdentifier: reuseId) {
                cell = reusedCell
            }
            else {
                cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: reuseId)
            }

            cell.textLabel?.text = "\(shoutOut.toEmployee.firstName) \(shoutOut.toEmployee.lastName)"
            cell.detailTextLabel?.text = shoutOut.shoutCategory

            return cell
        }.disposed(by: self.disposeBag)

        self.viewModel.fetchShoutOuts()
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

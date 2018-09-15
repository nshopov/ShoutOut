//
//  ViewController.swift
//  ShoutOut

import UIKit
import CoreData

class ShoutOutDraftsViewController: UIViewController,
									UITableViewDataSource,
									UITableViewDelegate,
                                    ManagedObjectContextDependentType,
                                    NSFetchedResultsControllerDelegate{

    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController<ShoutOut>!

	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

        self.configureFetchResultsController()

        do {
            try self.fetchedResultsController.performFetch()
        } catch  {
            let alertController = UIAlertController(title: "Loadint ShoutOuts failed", message: "There was a problem with loading your shoutouts", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
	}

    // MARK: -- Fetch results controller configuration
    func configureFetchResultsController() {
        let shoutOutFetchRequest = NSFetchRequest<ShoutOut>(entityName: ShoutOut.entityName)
        let lastNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.lastName), ascending: true)
        let firstNameSortDescriptor = NSSortDescriptor(key: #keyPath(ShoutOut.toEmployee.firstName), ascending: true)
        shoutOutFetchRequest.sortDescriptors = [lastNameSortDescriptor, firstNameSortDescriptor]

        self.fetchedResultsController = NSFetchedResultsController<ShoutOut>(fetchRequest: shoutOutFetchRequest,
                                                                             managedObjectContext: self.managedObjectContext,
                                                                             sectionNameKeyPath: nil,
                                                                             cacheName: nil)
        self.fetchedResultsController.delegate = self
    }

	// MARK: TableView Data Source methods
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return nil
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var result = 0
        if let sections = self.fetchedResultsController.sections {
            result = sections[section].numberOfObjects
        }
        return result
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell", for: indexPath)

        let shoutOut = self.fetchedResultsController.object(at: indexPath)

		cell.textLabel?.text = "\(shoutOut.toEmployee.firstName) \(shoutOut.toEmployee.lastName)"
		cell.detailTextLabel?.text = shoutOut.shoutCategory
		print(shoutOut.toEmployee.department)
		return cell
	}
	
	// MARK: TableView Delegate methods
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "shoutOutDetails":
            let destinationVC = segue.destination as! ShoutOutDetailsViewController
            let selectedIndexPath = self.tableView.indexPathForSelectedRow!
            let shoutOut = self.fetchedResultsController.object(at: selectedIndexPath)
            destinationVC.shoutOut = shoutOut
            destinationVC.managedObjectContext = self.managedObjectContext
        case "addShoutOut":
            let navC = segue.destination as! UINavigationController
            let destinationVC = navC.viewControllers[0] as! ShoutOutEditorViewController
            destinationVC.managedObjectContext = self.managedObjectContext
        default:
            break
        }

	}

    // MARK: -- NSFetch results contrller methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let insertIndexPath = newIndexPath {
                self.tableView.insertRows(at: [insertIndexPath], with: .fade)
            }
            break
        case .delete:
            if let deletedIndexPath = indexPath {
                self.tableView.deleteRows(at: [deletedIndexPath], with: .fade)
            }
            break
        case .update:
            if let updateIndexPath = indexPath {
                let cell = self.tableView.cellForRow(at: updateIndexPath)
                let updateShoutOut = self.fetchedResultsController.object(at: updateIndexPath)

                cell?.textLabel?.text = "\(updateShoutOut.toEmployee.firstName) \(updateShoutOut.toEmployee.lastName)"
                cell?.detailTextLabel?.text = updateShoutOut.shoutCategory
            }
            break
        case.move:
            if let deletedIndexPath = indexPath {
                self.tableView.deleteRows(at: [deletedIndexPath], with: .fade)
            }

            if let insertIndexPath = newIndexPath {
                self.tableView.insertRows(at: [insertIndexPath], with: .fade)
            }
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

}

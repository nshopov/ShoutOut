//
//  ShoutOutDetailsViewController.swift
//  ShoutOut

import UIKit
import CoreData

class ShoutOutDetailsViewController: UIViewController,
ManagedObjectContextDependentType {
    var managedObjectContext: NSManagedObjectContext!

    var shoutOut: ShoutOut!
    

	@IBOutlet weak var shoutCategoryLabel: UILabel!
	@IBOutlet weak var messageTextView: UITextView!
	@IBOutlet weak var fromLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSNotification.Name.NSManagedObjectContextDidSave,
                                               object: nil,
                                               queue: nil) { (notification: Notification) in
                                                if let updatedShoutOuts = notification.userInfo?[NSUpdatedObjectsKey] as? Set<ShoutOut> {
                                                    self.shoutOut = updatedShoutOuts.first
                                                    self.setUIValues()
                                                }
        }

        self.setUIValues()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name:
            Notification.Name.NSManagedObjectContextDidSave,
                                                  object: nil)
    }

    // MARK: -- Setup UI
    func setUIValues() {
        self.shoutCategoryLabel.text = self.shoutOut.shoutCategory
        self.messageTextView.text = self.shoutOut.message
        self.fromLabel.text = self.shoutOut.from
    }

	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let navC = segue.destination as! UINavigationController
        let destinationVC = navC.viewControllers[0] as! ShoutOutEditorViewController
        destinationVC.managedObjectContext = self.managedObjectContext
        destinationVC.shoutOut = self.shoutOut
	}

    @IBAction func deleteButtonTapped(_ sender: Any) {
        let alertConttoller = UIAlertController(title: "Delete ShoutOut", message: "Are you sure you want to delete this shoutout?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            self.managedObjectContext.delete(self.shoutOut)

            do {
                try self.managedObjectContext.save()
            } catch {
                self.managedObjectContext.rollback()
                print("Something ugly have happened! \(error)")
            }

            let _ = self.navigationController?.popViewController(animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)


        alertConttoller.addAction(deleteAction)
        alertConttoller.addAction(cancelAction)

        self.present(alertConttoller, animated: true, completion: nil)
    }
}

//
//  ShoutOutEditorViewController.swift
//  ShoutOut

import UIKit
import CoreData
class ShoutOutEditorViewController: UIViewController,
                                    ManagedObjectContextDependentType,
                                    UIPickerViewDataSource,
UIPickerViewDelegate {
    var managedObjectContext: NSManagedObjectContext!

	@IBOutlet weak var toEmployeePicker: UIPickerView!
	@IBOutlet weak var shoutCategoryPicker: UIPickerView!
	@IBOutlet weak var messageTextView: UITextView!
	@IBOutlet weak var fromTextField: UITextField!

    let shoutOutCategories = [
        "Great Job!",
        "Awesome Work!",
        "Well Done!",
        "Amazing Effort!"
    ]

    var employees: [Employee]!
    var shoutOut: ShoutOut!


	override func viewDidLoad() {
		super.viewDidLoad()

        self.employees =  self.fetchEmployees()



        self.toEmployeePicker.delegate = self
        self.toEmployeePicker.dataSource = self
        self.toEmployeePicker.tag = 0

        self.shoutCategoryPicker.delegate = self
        self.shoutCategoryPicker.dataSource = self
        self.shoutCategoryPicker.tag = 1

        self.shoutOut = self.shoutOut ?? NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName, into: self.managedObjectContext) as! ShoutOut

        self.setupUIValues()

		messageTextView.layer.borderWidth = CGFloat(0.5)
		messageTextView.layer.borderColor = UIColor(displayP3Red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
		messageTextView.layer.cornerRadius = 5
		messageTextView.clipsToBounds = true


	}

    // MARK: -- Setup UI
    func setupUIValues() {
        // Employee picker
        let selectedEmployeeRow = self.employees.index(of: self.shoutOut.toEmployee) ?? 0
        self.toEmployeePicker.selectRow(selectedEmployeeRow, inComponent: 0, animated: true)

        // Categories picker
        let selectedCategoryRow = self.shoutOutCategories.index(of: self.shoutOut.shoutCategory) ?? 0
        self.shoutCategoryPicker.selectRow(selectedCategoryRow, inComponent: 0, animated: true)

        // Text Views
        self.messageTextView.text = self.shoutOut.message
        self.fromTextField.text = self.shoutOut.from
    }

	@IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.managedObjectContext.rollback()
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
		let selectedEmployeeIndex = self.toEmployeePicker.selectedRow(inComponent: 0)
        let selectedEmployee = self.employees[selectedEmployeeIndex]
        self.shoutOut.toEmployee = selectedEmployee

        let selectedCategoryIndex = self.shoutCategoryPicker.selectedRow(inComponent: 0)
        let selectedCategory = self.shoutOutCategories[selectedCategoryIndex]
        self.shoutOut.shoutCategory = selectedCategory

        self.shoutOut.message = self.messageTextView.text
        self.shoutOut.from = self.fromTextField.text ?? "Anonymous"

        do {
            try self.managedObjectContext.save()
            self.dismiss(animated: true, completion: nil)
        } catch  {
            let alert = UIAlertController(title: "Trouble saving", message: "Something ugly have happned during the saving of your shoutout", preferredStyle: .alert)

            let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) -> Void in
                self.managedObjectContext.rollback()
                self.shoutOut = NSEntityDescription.insertNewObject(forEntityName: ShoutOut.entityName, into: self.managedObjectContext) as! ShoutOut
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
	}

    // MARK: -- Core Data
    func fetchEmployees() -> [Employee] {
        var result = [Employee]()

        let employeeFetchRequest = NSFetchRequest<Employee>(entityName: Employee.entityName)

        let primarySortDescriptor = NSSortDescriptor(key: #keyPath(Employee.lastName), ascending: true)

        let secondarySortDescriptor = NSSortDescriptor(key: #keyPath(Employee.firstName), ascending: true)

        employeeFetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]

        do {
            result = try self.managedObjectContext.fetch(employeeFetchRequest)
        } catch  {
            print("Error when fetching employees form the persistance store! \(error)")
        }
        return result
    }

    // MARK: -- Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 0 ? self.employees.count: self.shoutOutCategories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            let employee = self.employees[row]
            return "\(employee.firstName) \(employee.lastName)"
        } else {
            return self.shoutOutCategories[row]
        }

    }
}

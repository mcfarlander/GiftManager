//
//  OrganizationViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/5/16.
//  Copyright © 2016 David Johnson. All rights reserved.
//

import Cocoa

/// A view controller to show the organizations and allow the user to perform data operations on them.
class OrganizationViewController: NSViewController {
	
	var managedContext = (NSApplication.shared.delegate as! AppDelegate).managedObjectContext
    
	@IBOutlet var tableView: NSTableView!
	@IBOutlet weak var btnAddOrg: NSButton!
    @IBOutlet weak var btnUpdateOrg: NSButton!
    @IBOutlet weak var btnDeleteOrg: NSButton!
	
	@IBOutlet weak var btnAddOrgTouchbar: NSButton!
	@IBOutlet weak var btnUpdateOrgTouchbar: NSButton!
	@IBOutlet weak var btnDeleteOrgTouchbar: NSButton!
	
	fileprivate let organizationDao = OrganizationDao()
	fileprivate var currentOrganization:Organization? = nil
	fileprivate var operation:DataOperation = DataOperation.Add
	
	lazy var organizationEditViewController: OrganizationEditViewController =
	{
			return self.storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "OrganizationEditViewController")) as! OrganizationEditViewController
	}()
	
	/// The view loaded.
    override func viewDidLoad() {
		
        super.viewDidLoad()
        // Do view setup here.
        NSLog("Organizations view did load")
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
    }
	
	/// The view appeared, perhaps after being closed.
	override func viewDidAppear() {
		self.enableUpdateDeleteButtons()
		self.tableView.reloadData()
	}

	/// Button action to add an organization.
	///
	/// - Parameter sender: the view's add button
    @IBAction func btnAddOrg_Action(_ sender: NSButton) {
		
        NSLog("add org action")
		self.currentOrganization = self.organizationDao.create(name: " ", phone: " ")
		self.operation = DataOperation.Add
		self.performDataAction()
    }

	/// Button action to modify an organization.
	///
	/// - Parameter sender: the view's update button
    @IBAction func btnUpdateOrg_Action(_ sender: NSButton) {
		
        NSLog("update org action")
		
		if self.currentOrganization != nil {
			self.operation = DataOperation.Update
			self.performDataAction()
		} else {
			NSLog("No organization selected")
			showOkMessage(title:"Data", message:"Organization not selected.")
		}
    }
	
	/// Button action to delete an organization.
	///
	/// - Parameter sender: the view's delete button
    @IBAction func btnDeleteOrg_Action(_ sender: NSButton) {
		
        NSLog("delete org action")

		if self.currentOrganization != nil {
			self.operation = DataOperation.Delete
			self.performDataAction()
		} else {
			NSLog("No organization selected")
			showOkMessage(title:"Data", message:"Organization not selected.")
		}
    }
	
	/// Enable or disable the buttons on the view depending if a row has been selected.
	fileprivate func enableUpdateDeleteButtons() {
		self.btnUpdateOrg.isEnabled = self.currentOrganization != nil
		self.btnUpdateOrgTouchbar.isEnabled = self.currentOrganization != nil
		self.btnDeleteOrg.isEnabled = self.currentOrganization != nil
		self.btnDeleteOrgTouchbar.isEnabled = self.currentOrganization != nil
	}
	
	/// Create the data operation, the object to manipulate and open the sheet to perform the operation.
	fileprivate func performDataAction() {
		self.organizationEditViewController.delegate = self
		self.organizationEditViewController.organization = self.currentOrganization!
		self.organizationEditViewController.operation = self.operation
		
		self.presentViewControllerAsSheet(organizationEditViewController)
	}
	
}

// MARK: - SheetViewControllerDelegate

extension OrganizationViewController:SheetViewControllerDelegate
{
	func handleUpdate(isCanceled: Bool) {
		
		if isCanceled && self.operation == .Add {
			self.currentOrganization = nil
		}
		
		self.tableView.reloadData()
		self.enableUpdateDeleteButtons()
	}
}

// MARK: - NSTableViewDelegate, NSTableViewDataSource

extension OrganizationViewController: NSTableViewDelegate, NSTableViewDataSource
{
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return self.organizationDao.list()!.count
	}
	
	func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
		
		if row >= 0 {
			self.currentOrganization = self.organizationDao.list()![row]
			NSLog("selected organization: " + (self.currentOrganization?.name)!)
		} else {
			self.currentOrganization = nil;
		}
		
		enableUpdateDeleteButtons()
		
		return true
	}
	
	fileprivate enum CellIdentifiers {
		static let CellName = "cellOrganizationName"
		static let CellPhone = "cellOrganizationPhone"
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		
		var text: String = ""
		var cellIdentifier: String = ""
		
		let org = self.organizationDao.list()![row]
		
		if tableColumn == tableView.tableColumns[0] {
			text = org.name!
			cellIdentifier = CellIdentifiers.CellName
		} else if tableColumn == tableView.tableColumns[1] {
			text = org.phone!
			cellIdentifier = CellIdentifiers.CellPhone
		}
		
		if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
			cell.textField?.stringValue = text
			return cell
		}
		
		return nil
	}
	
}

//
//  OrganizationViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/5/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa

class OrganizationViewController: NSViewController
{
	var managedContext = (NSApplication.shared.delegate as! AppDelegate).managedObjectContext
    
	@IBOutlet var tableView: NSTableView!
	@IBOutlet weak var btnAddOrg: NSButton!
    @IBOutlet weak var btnUpdateOrg: NSButton!
    @IBOutlet weak var btnDeleteOrg: NSButton!
	
	fileprivate let organizationDao = OrganizationDao()
	fileprivate var currentOrganization:Organization? = nil
	fileprivate var operation:DataOperation = DataOperation.Add
	
	lazy var organizationEditViewController: OrganizationEditViewController =
	{
			return self.storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "OrganizationEditViewController")) as! OrganizationEditViewController
	}()
    
    override func viewDidLoad() {
		
        super.viewDidLoad()
        // Do view setup here.
        NSLog("Organizations view did load")
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		self.enableUpdateDeleteButtons()
    }
	
	override func viewDidAppear() {
		self.enableUpdateDeleteButtons()
		self.tableView.reloadData()
	}

    @IBAction func btnAddOrg_Action(_ sender: NSButton) {
        NSLog("add org action")
		self.currentOrganization = self.organizationDao.create(name: " ", phone: " ")
		self.operation = DataOperation.Add
		self.performDataAction()
        
    }

    @IBAction func btnUpdateOrg_Action(_ sender: NSButton) {
        NSLog("update org action")
		self.currentOrganization = self.organizationDao.list()![tableView.selectedRow]
		self.operation = DataOperation.Update
		self.performDataAction()
    }
    
    @IBAction func btnDeleteOrg_Action(_ sender: NSButton) {
        NSLog("delete org action")
		self.currentOrganization = self.organizationDao.list()![tableView.selectedRow]
		self.operation = DataOperation.Delete
		self.performDataAction()
    }
	
	fileprivate func enableUpdateDeleteButtons() {
		self.btnUpdateOrg.isEnabled = self.organizationDao.list()!.count > 0
		self.btnDeleteOrg.isEnabled = self.organizationDao.list()!.count > 0
	}
	
	fileprivate func performDataAction() {
		self.organizationEditViewController.delegate = self
		self.organizationEditViewController.organization = self.currentOrganization!
		self.organizationEditViewController.operation = self.operation
		
		self.presentViewControllerAsSheet(organizationEditViewController)
	}
	
}

extension OrganizationViewController:SheetViewControllerDelegate
{
	func handleUpdate() {
		self.tableView.reloadData()
	}
}

extension OrganizationViewController: NSTableViewDelegate, NSTableViewDataSource
{
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return self.organizationDao.list()!.count
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

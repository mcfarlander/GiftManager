//
//  RouteViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/5/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa
import CoreData

/// A view controller to show the routes and allow the user to perform data operations on them.
class RouteViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var btnAdd: NSButton!
    @IBOutlet weak var btnUpdate: NSButton!
    @IBOutlet weak var btnDelete: NSButton!
	
	@IBOutlet weak var btnAddTouchbar: NSButton!
	@IBOutlet weak var btnUpdateTouchbar: NSButton!
	@IBOutlet weak var btnDeleteTouchbar: NSButton!
	
	fileprivate let routeDao = RouteDao()
	
	fileprivate var currentRoute:Route? = nil
    fileprivate var operation:DataOperation = DataOperation.Add
    
    lazy var routeEditViewController: RouteEditViewController = {
		return self.storyboard!.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "RouteEditViewController")) as! RouteEditViewController
    }()

	/// The view loaded.
    override func viewDidLoad() {
		
        super.viewDidLoad()
        // Do view setup here.
        NSLog("Routes view did load")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
	
	/// The view appeared, perhaps after being closed.
	override func viewDidAppear() {
		self.enableUpdateDeleteButtons()
		self.tableView.reloadData()
	}
    
    /// Button action to add a route.
    ///
    /// - Parameter sender: the view's add button
    @IBAction func btnAdd_Action(_ sender: NSButton) {
        NSLog("Routes view btnAdd Action")
        self.currentRoute = self.routeDao.create(routeNumber: " ", street: " ")
        self.operation = DataOperation.Add
        self.performDataAction()
    }
    
    /// Button action to modify a route.
    ///
    /// - Parameter sender: the view's update button
    @IBAction func btnUpdate_Action(_ sender: NSButton) {
        NSLog("Routes view btnUpdate Action")
		
		if self.currentRoute != nil {
			self.operation = DataOperation.Update
			self.performDataAction()
		} else {
			NSLog("No route selected")
			showOkMessage(title:"Data", message:"Route not selected.")
		}

    }
    
    /// Button action to delete a route.
    ///
    /// - Parameter sender: the view's delete button
    @IBAction func btnDelete_Action(_ sender: NSButton) {
        NSLog("Routes view btnDelete Action")
		
		if self.currentRoute != nil {
			self.operation = DataOperation.Delete
			self.performDataAction()
		} else {
			NSLog("No route selected")
			showOkMessage(title:"Data", message:"Rotue not selected.")
		}
    }
    
    /// Create the data operation, the object to manipulate and open the sheet to perform the operation.
    fileprivate func performDataAction() {
		self.routeEditViewController.delegate = self
		self.routeEditViewController.route = self.currentRoute!
        self.routeEditViewController.operation = self.operation
		
		self.presentViewControllerAsSheet(routeEditViewController)
    }
    
    /// Enable or disable the buttons on the view depending if a row has been selected.
    fileprivate func enableUpdateDeleteButtons() {
        btnUpdate.isEnabled = self.currentRoute != nil
		btnUpdateTouchbar.isEnabled = self.currentRoute != nil
        btnDelete.isEnabled = self.currentRoute != nil
		btnDeleteTouchbar.isEnabled = self.currentRoute != nil
    }
    
}

// MARK: - SheetViewControllerDelegate

extension RouteViewController:SheetViewControllerDelegate
{
	func handleUpdate(isCanceled: Bool) {
		
		if isCanceled  && self.operation == .Add {
			self.currentRoute = nil
		}
		
		self.tableView.reloadData()
		self.enableUpdateDeleteButtons()
	}
}

// MARK: - NSTableViewDelegate, NSTableViewDataSource

extension RouteViewController: NSTableViewDelegate, NSTableViewDataSource
{
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return self.routeDao.list()!.count
	}
    
    fileprivate enum CellIdentifiers {
        static let CellRouteNumber = "cellRouteNumber"
        static let CellStreet = "cellStreet"
    }
	
	func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
		
		if row >= 0 {
			self.currentRoute = self.routeDao.list()![row]
			NSLog("selected route: " + (self.currentRoute?.routenumber!)!)
		} else {
			self.currentRoute = nil;
		}
		
		enableUpdateDeleteButtons()
		
		return true
	}
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		
        var text: String = ""
        var cellIdentifier: String = ""
		
		let route = self.routeDao.list()![row]

        if tableColumn == tableView.tableColumns[0] {
            text = route.routenumber!
            cellIdentifier = CellIdentifiers.CellRouteNumber
			
        } else if tableColumn == tableView.tableColumns[1] {
            text = route.street!
            cellIdentifier = CellIdentifiers.CellStreet
        }
        
		if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
 
        return nil
    }
    
}

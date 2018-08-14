//
//  RouteViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/5/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa
import CoreData

class RouteViewController: NSViewController
{
    
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

    override func viewDidLoad() {
		
        super.viewDidLoad()
        // Do view setup here.
        NSLog("Routes view did load")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
		
        self.enableUpdateDeleteButtons()
        
    }
	
	override func viewDidAppear() {
		self.enableUpdateDeleteButtons()
		self.tableView.reloadData()
	}
    
    @IBAction func btnAdd_Action(_ sender: NSButton) {
        NSLog("Routes view btnAdd Action")
        self.currentRoute = self.routeDao.create(routeNumber: " ", street: " ")
        self.operation = DataOperation.Add
        self.performDataAction()
    }
    
    @IBAction func btnUpdate_Action(_ sender: NSButton) {
        NSLog("Routes view btnUpdate Action")
        self.currentRoute = self.routeDao.list()![tableView.selectedRow]
        self.operation = DataOperation.Update
        self.performDataAction()

    }
    
    @IBAction func btnDelete_Action(_ sender: NSButton) {
        NSLog("Routes view btnDelete Action")
        self.currentRoute = self.routeDao.list()![tableView.selectedRow]
        self.operation = DataOperation.Delete
        self.performDataAction()
    }
    
    fileprivate func performDataAction() {
		self.routeEditViewController.delegate = self
		self.routeEditViewController.route = self.currentRoute!
        self.routeEditViewController.operation = self.operation
		
		self.presentViewControllerAsSheet(routeEditViewController)
    }
    
    fileprivate func enableUpdateDeleteButtons() {
        btnUpdate.isEnabled = self.routeDao.list()!.count > 0
        btnDelete.isEnabled = self.routeDao.list()!.count > 0
    }
    
}

extension RouteViewController:SheetViewControllerDelegate
{
	func handleUpdate() {
		self.tableView.reloadData()
	}
}

extension RouteViewController: NSTableViewDelegate, NSTableViewDataSource
{
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return self.routeDao.list()!.count
	}
    
    fileprivate enum CellIdentifiers {
        static let CellRouteNumber = "cellRouteNumber"
        static let CellStreet = "cellStreet"
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

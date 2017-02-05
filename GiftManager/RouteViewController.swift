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
    
    fileprivate let commonFetch = CommonFetches()
    fileprivate var routes:[Route] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
        NSLog("Routes view did load")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        routes = commonFetch.getAllRoutes()
        
        
    }
    
    @IBAction func btnAdd_Action(_ sender: NSButton)
    {
        NSLog("Routes view btnAdd Action")
    }
    
    @IBAction func btnUpdate_Action(_ sender: NSButton)
    {
        NSLog("Routes view btnUpdate Action")
    }
    
    @IBAction func btnDelete_Action(_ sender: NSButton)
    {
        NSLog("Routes view btnDelete Action")
    }
    
    
}

extension RouteViewController: NSTableViewDataSource
{
    func numberOfRows(in tableView: NSTableView) -> Int
    {
        return routes.count

    }
    
}

extension RouteViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers
    {
        static let CellRouteNumber = "cellRouteNumber"
        static let CellStreet = "cellStreet"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
       
        var text: String = ""
        var cellIdentifier: String = ""

        if tableColumn == tableView.tableColumns[0] {
            text = routes[row].routenumber!
            cellIdentifier = CellIdentifiers.CellRouteNumber
        } else if tableColumn == tableView.tableColumns[1] {
            text = routes[row].street!
            cellIdentifier = CellIdentifiers.CellStreet
        }
        
        if let cell = tableView.make(withIdentifier: cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
 
        return nil
    }
    
}

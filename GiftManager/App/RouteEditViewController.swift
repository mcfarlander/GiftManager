//
//  RouteEditViewController.swift
//  GiftManager
//
//  Created by David Johnson on 2/5/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Cocoa

class RouteEditViewController: NSViewController {
	
    @IBOutlet weak var txtRouteNumber: NSTextField!
    @IBOutlet weak var txtStreetName: NSTextField!
    
    @IBOutlet weak var btnOk: NSButton!
    @IBOutlet weak var btnCancel: NSButton!
	
	var delegate:SheetViewControllerDelegate?
    var route:Route? = nil
    var operation:DataOperation = DataOperation.Delete
	
	fileprivate let routeDao = RouteDao()
	
    override func viewDidLoad() {
		super.viewDidLoad()
    }
	
	override func viewDidAppear() {
		
		super.viewDidAppear()
		self.view.window?.unbind(NSBindingName(rawValue: #keyPath(touchBar))) // unbind first
		self.view.window?.bind(NSBindingName(rawValue: #keyPath(touchBar)), to: self, withKeyPath: #keyPath(touchBar), options: nil)
		
		txtRouteNumber.stringValue = (route?.routenumber!)!.trim()
		txtStreetName.stringValue = (route?.street!)!.trim()
		
		switch operation
		{
		case DataOperation.Add:
			txtRouteNumber.isEnabled = true
			txtStreetName.isEnabled = true
		case DataOperation.Update:
			txtRouteNumber.isEnabled = true
			txtStreetName.isEnabled = true
		case DataOperation.Delete:
			txtRouteNumber.isEnabled = false
			txtStreetName.isEnabled = false
		}
	}

    @IBAction func btnOk_Action(_ sender: NSButton) {
		
		if validate() {
			self.route?.routenumber = txtRouteNumber.stringValue
			self.route?.street = txtStreetName.stringValue
			
			switch self.operation
			{
			case .Add, .Update:
					self.routeDao.update(route: self.route!)
			case .Delete:
					self.routeDao.delete(route: self.route!)
			}
			
			self.delegate?.handleUpdate(isCanceled: false)
			self.dismiss(self)
		}
    }
	
	@IBAction func btnCancel_Action(_ sender: NSButton) {
		
		if self.operation == .Add {
			self.routeDao.delete(route: self.route!)
		}
		
		self.delegate?.handleUpdate(isCanceled: true)
		self.dismiss(self)
	}
	
	private func validate() -> Bool {
		
		if self.operation == .Delete {
			return true
		}
		
		if self.txtRouteNumber.stringValue.count == 0 {
			self.showOkMessage(title: "Input Needed", message: "Please enter the route number")
			return false
		}
		
		if self.txtStreetName.stringValue.count == 0 {
			self.showOkMessage(title: "Input Needed", message: "Please enter the street name")
			return false
		}
		
		return true
	}
    
}

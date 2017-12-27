//
//  HouseEditViewController.swift
//  GiftManager
//
//  Created by Dave on 12/13/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Cocoa

class HouseEditViewController: NSViewController
{
	@IBOutlet var labelNumber: NSTextField!
	@IBOutlet var textNumber: NSTextField!
	@IBOutlet var labelContact: NSTextField!
	@IBOutlet var textContact: NSTextField!
	@IBOutlet var labelPhone: NSTextField!
	@IBOutlet var textPhone: NSTextField!
	@IBOutlet var labelAddress: NSTextField!
	@IBOutlet var textAddress: NSTextField!
	@IBOutlet var labelNote: NSTextField!
	@IBOutlet var textNote: NSTextField!
	@IBOutlet var labelRoute: NSTextField!
	@IBOutlet var textRoute: NSComboBoxCell!
	@IBOutlet var switchDeliver: NSButton!
	@IBOutlet var switchPrinted: NSButton!
	
	@IBOutlet weak var btnOk: NSButton!
	@IBOutlet weak var btnCancel: NSButton!
	
	var delegate:HousePersonViewControllerDelegate?
	var operation:DataOperation = DataOperation.Delete
	var house:House? = nil
	
	fileprivate let houseDao = HouseDao()
	fileprivate let routeDao = RouteDao()

    override func viewDidLoad()
	{
        super.viewDidLoad()
        // Do view setup here.
    }
	
	override func viewDidAppear()
	{
		self.populateRoutes()

		self.textNumber.stringValue = (house?.sequence)!.toString()
		self.textContact.stringValue = (self.house?.contact) ?? ""
		self.textPhone.stringValue = (self.house?.phone) ?? ""
		self.textAddress.stringValue = (self.house?.address) ?? ""
		self.textNote.stringValue = (self.house?.notes) ?? ""
		self.textRoute.stringValue = (self.house?.route?.routenumber) ?? ""
		
		if (self.house?.deliver)!
		{
			self.switchDeliver.state = .on
		}
		else
		{
			self.switchDeliver.state = .off
		}
		
		if (self.house?.printed)!
		{
			self.switchPrinted.state = .on
		}
		else
		{
			self.switchPrinted.state = .off
		}
		
		switch operation
		{
		case .Add, .Update:
			self.enableControls(isEnabled: true)
		case DataOperation.Delete:
			self.enableControls(isEnabled: false)
		}
	}
	
	@IBAction func btnOk_Action(_ sender: NSButton)
	{
		if self.validate()
		{
			
			self.house?.sequence = self.textNumber.intValue
			self.house?.contact = self.textContact.stringValue
			self.house?.phone = self.textPhone.stringValue
			self.house?.address = self.textAddress.stringValue
			self.house?.notes = self.textNote.stringValue
			
			self.house?.route = self.routeDao.getRoute(routeNumber: self.textRoute.stringValue)
			
			if self.switchDeliver.state == .on
			{
				self.house?.deliver = true
			}
			else
			{
				self.house?.deliver = false
			}
			
			if self.switchPrinted.state == .on
			{
				self.house?.printed = true
			}
			else
			{
				self.house?.printed = false
			}
			
			switch self.operation
			{
			case .Add, .Update:
				self.houseDao.update(house: self.house!)
			case .Delete:
				self.houseDao.delete(house: self.house!)
			}
			
			self.delegate?.handleUpdateHouse()
			self.dismiss(self)
		}
	}
	
	@IBAction func btnCancel_Action(_ sender: NSButton)
	{
		if self.operation == .Add
		{
			self.houseDao.delete(house: self.house!)
		}
		
		self.delegate?.handleUpdateHouse()
		self.dismiss(self)
	}
	
	private func populateRoutes()
	{
		self.textRoute.removeAllItems()
		self.textRoute.addItem(withObjectValue: "")
		
		for route:Route in self.routeDao.list()!
		{
			self.textRoute.addItem(withObjectValue: route.routenumber!)
		}
		
	}
	
	private func validate() -> Bool
	{
		if self.operation == .Delete
		{
			return true
		}
		
		if self.textNumber.stringValue.count == 0
		{
			self.showOkMessage(title: "Input Needed", message: "Please enter the sequence number")
			return false
		}
		
		if self.textContact.stringValue.count == 0
		{
			self.showOkMessage(title: "Input Needed", message: "Please enter the contact name")
			return false
		}
		
		if self.textPhone.stringValue.count == 0
		{
			self.showOkMessage(title: "Input Needed", message: "Please enter the phone number")
			return false
		}
		
		return true
	}
	
	private func enableControls(isEnabled:Bool)
	{
		self.textNumber.isEnabled = isEnabled
		self.textContact.isEnabled = isEnabled
		self.textPhone.isEnabled = isEnabled
		self.textAddress.isEnabled = isEnabled
		self.textNote.isEnabled = isEnabled
		self.textRoute.isEnabled = isEnabled
		self.switchDeliver.isEnabled = isEnabled
		self.switchPrinted.isEnabled = isEnabled
		
	}
    
}

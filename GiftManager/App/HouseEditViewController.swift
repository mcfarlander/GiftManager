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
	@IBOutlet var textRoute: NSTextField!
	@IBOutlet var switchDeliver: NSButton!
	@IBOutlet var switchPrinted: NSButton!
	
	@IBOutlet weak var btnOk: NSButton!
	@IBOutlet weak var btnCancel: NSButton!
	
	var delegate:SheetViewControllerDelegate?
	var operation:DataOperation = DataOperation.Delete
	var house:House? = nil
	
	fileprivate let houseDao = HouseDao()

    override func viewDidLoad()
	{
        super.viewDidLoad()
        // Do view setup here.
    }
	
	override func viewDidAppear()
	{
		self.textNumber.stringValue = String(describing: house?.sequence)
		self.textContact.stringValue = (self.house?.contact)!
		self.textPhone.stringValue = (self.house?.contact)!
		self.textAddress.stringValue = (self.house?.contact)!
		self.textNote.stringValue = (self.house?.contact)!
		self.textRoute.stringValue = (self.house?.contact)!
		
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
			switch self.operation
			{
			case .Add, .Update:
				self.houseDao.update(house: self.house!)
			case .Delete:
				self.houseDao.delete(house: self.house!)
			}
			
			self.delegate?.handleUpdate()
			self.dismiss(self)
		}
	}
	
	@IBAction func btnCancel_Action(_ sender: NSButton)
	{
		self.dismiss(self)
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

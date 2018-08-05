//
//  PersonEditViewController.swift
//  GiftManager
//
//  Created by Dave on 12/13/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Cocoa

class PersonEditViewController: NSViewController
{
	
	@IBOutlet var labelNumber: NSView!
	@IBOutlet var textNumber: NSTextField!
	@IBOutlet var labelName: NSTextField!
	@IBOutlet var textName: NSTextField!
	@IBOutlet var labelAge: NSTextField!
	@IBOutlet var textAge: NSTextField!
	@IBOutlet var buttonIsMale: NSButton!
	@IBOutlet var buttonIsHouseholdGift: NSButton!
	@IBOutlet var labelGiftIdeas: NSTextField!
	@IBOutlet var textGiftIdeas: NSComboBox!
	@IBOutlet var labelOrganization: NSTextField!
	@IBOutlet var textOrganization: NSComboBox!
	
	@IBOutlet weak var btnOk: NSButton!
	@IBOutlet weak var btnCancel: NSButton!
	
	var delegate:HousePersonViewControllerDelegate?
	var operation:DataOperation = DataOperation.Delete
	var person:Person? = nil
	
	fileprivate let personDao = PersonDao()
	fileprivate let organizationDao = OrganizationDao()

    override func viewDidLoad()
	{
        super.viewDidLoad()
        // Do view setup here.
    }
	
	override func viewDidAppear()
	{
		populateGiftIdeas()
		self.populateOrgs()
		
		self.textNumber.stringValue = (person?.sequence!)!
		self.textName.stringValue = person?.name ?? ""
		self.textAge.stringValue = person?.age ?? ""
		self.buttonIsMale.state = (person?.ismale)! ? .on : .off
		self.buttonIsHouseholdGift.state = (person?.ishousegift)! ? .on : .off
		self.textGiftIdeas.stringValue = person?.giftideas ?? ""
		self.textOrganization.stringValue = person?.organization?.name ?? ""
		
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
		if validate()
		{
			
			self.person?.sequence = self.textNumber.stringValue
			self.person?.name = self.textName.stringValue
			self.person?.age = self.textAge.stringValue
			
			if self.buttonIsMale.state == .on
			{
				self.person?.ismale = true
			}
			else
			{
				self.person?.ismale = false
			}
			
			if self.buttonIsHouseholdGift.state == .on
			{
				self.person?.ishousegift = true
			}
			else
			{
				self.person?.ishousegift = false
			}
			
			self.person?.giftideas = self.textGiftIdeas.stringValue
			
			self.person?.organization = self.organizationDao.getOrganization(name: self.textOrganization.stringValue)
			
			switch self.operation
			{
			case .Add, .Update:
				self.personDao.update(person: self.person!)
			case .Delete:
				self.personDao.delete(person: self.person!)
			}
			
			self.delegate?.handleUpdatePerson(isCanceled: false)
			self.dismiss(self)
		}
	}
	
	@IBAction func btnCancel_Action(_ sender: NSButton)
	{
		if self.operation == .Add
		{
			self.personDao.delete(person: self.person!)
		}
		
		self.delegate?.handleUpdatePerson(isCanceled: true)
		self.dismiss(self)
	}
	
	private func populateGiftIdeas()
	{
		self.textGiftIdeas.removeAllItems()
		
		let items = [
			"",
			"McFarland Resaurant Gift Card",
			"McFarland Retail Store Gift Card",
			"McFarland Gas Station Gift Card",
			"Culvers Gift Card",
			"Walgreens Gift Card",
			"Medicine Shoppe Gift Card",
			"McFarland House Cafe Gift Card",
			"Dollar General Gift Card",
			"Kwik Trip Gift Card"]
		
		self.textGiftIdeas.addItems(withObjectValues: items)
		
	}
	
	private func populateOrgs()
	{
		self.textOrganization.removeAllItems()
		
		self.textOrganization.addItem(withObjectValue: "")
		
		for org:Organization in self.organizationDao.list()!
		{
			self.textOrganization.addItem(withObjectValue: org.name!)
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
		
		if self.textName.stringValue.count == 0
		{
			self.showOkMessage(title: "Input Needed", message: "Please enter the name")
			return false
		}
		
		if self.textGiftIdeas.stringValue.count == 0
		{
			self.showOkMessage(title: "Input Needed", message: "Please enter the gift ideas")
			return false
		}
		
		return true
	}
	
	private func enableControls(isEnabled:Bool)
	{
		self.textNumber.isEnabled = isEnabled
		self.textName.isEnabled = isEnabled
		self.textAge.isEnabled = isEnabled
		self.buttonIsMale.isEnabled = isEnabled
		self.buttonIsHouseholdGift.isEnabled = isEnabled
		self.textGiftIdeas.isEnabled = isEnabled
		self.textOrganization.isEnabled = isEnabled
	}
    
	@IBAction func ButtonOK_Action(_ sender: NSButton) {
		
	}
	
	@IBAction func ButtonCancel_Action(_ sender: NSButton) {
		
	}
	
}

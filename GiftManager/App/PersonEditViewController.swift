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

    override func viewDidLoad()
	{
        super.viewDidLoad()
        // Do view setup here.
    }
	
	@IBAction func btnOk_Action(_ sender: NSButton)
	{
		if validate()
		{
			
			switch self.operation
			{
			case .Add, .Update:
				self.personDao.update(person: self.person!)
			case .Delete:
				self.personDao.delete(person: self.person! )
			}
			
			self.delegate?.handleUpdatePerson()
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
		
		
		return true
	}
    
}

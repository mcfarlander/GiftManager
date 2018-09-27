//
//  PersonEditViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/13/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Cocoa

/// The controller for performing a data operation on a Person object.
class PersonEditViewController: NSViewController, NSTouchBarDelegate {
	
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

	/// The view loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	/// The view appeared, perhaps after being closed.
	override func viewDidAppear() {
		
		self.populateGiftIdeas()
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
	
	/// Creates the touchbar for this view.
	///
	/// - Returns: the new touchbar
	override func makeTouchBar() -> NSTouchBar? {
		
		let touchBarIdenitifier = NSTouchBar.CustomizationIdentifier("org.giftmanager.person.TouchBarRoute")
		let touchBarOkIdentifier = NSTouchBarItem.Identifier(rawValue: "org.giftmanager.person.Ok.button")
		let touchBarCancelIdentifier = NSTouchBarItem.Identifier(rawValue: "org.giftmanager.person.Cancel.button")
		
		let touchBar = NSTouchBar()
		touchBar.delegate = self
		touchBar.customizationIdentifier = touchBarIdenitifier
		touchBar.defaultItemIdentifiers = [touchBarOkIdentifier, touchBarCancelIdentifier, .fixedSpaceLarge, .otherItemsProxy]
		touchBar.customizationAllowedItemIdentifiers = [touchBarCancelIdentifier]
		
		return touchBar
	}
	
	/// Callback for when the touchbar is touched.
	///
	/// - Parameters:
	///   - touchBar: the view's touch bar
	///   - identifier: the identifier of the control being touched
	/// - Returns: the touch bar item
	func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
		
		let custom = NSCustomTouchBarItem(identifier: identifier)
		
		switch identifier.rawValue {
			
		case "org.giftmanager.person.Ok.button":
			
			let button = NSButton(title: Constants.Text_Button_OK, target: self, action: #selector(btnOk_Action(_:)))
			button.bezelColor = Constants.Color_Button_OK
			custom.view = button
			
		case "org.giftmanager.person.Cancel.button":
			
			let button = NSButton(title: Constants.Text_Button_Cancel, target: self, action: #selector(btnCancel_Action(_:)))
			button.bezelColor = Constants.Color_Button_Cancel
			custom.view = button
			
		default:
			return nil
		}
		
		return custom
		
	}
	
	/// Attempt to complate the data operation.
	///
	/// - Parameter sender: the view's button
	@IBAction func btnOk_Action(_ sender: NSButton) {
		
		if validate() {
			
			self.person?.sequence = self.textNumber.stringValue
			self.person?.name = self.textName.stringValue
			self.person?.age = self.textAge.stringValue
			
			if self.buttonIsMale.state == .on {
				self.person?.ismale = true
			} else {
				self.person?.ismale = false
			}
			
			if self.buttonIsHouseholdGift.state == .on {
				self.person?.ishousegift = true
			} else {
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
	
	/// Cancel performing the data operation.
	///
	/// - Parameter sender: the view's button
	@IBAction func btnCancel_Action(_ sender: NSButton) {
		
		if self.operation == .Add {
			self.personDao.delete(person: self.person!)
		}
		
		self.delegate?.handleUpdatePerson(isCanceled: true)
		self.dismiss(self)
	}
	
	/// Populate the drop-down list of common gift ideas.
	private func populateGiftIdeas() {
		
		self.textGiftIdeas.removeAllItems()
		self.textGiftIdeas.addItems(withObjectValues: CommonItems.items)
		
	}
	
	/// Get the list of organizations and populate the org drop-down control.
	private func populateOrgs() {
		self.textOrganization.removeAllItems()
		self.textOrganization.addItem(withObjectValue: "")
		
		for org:Organization in self.organizationDao.list()! {
			self.textOrganization.addItem(withObjectValue: org.name!)
		}
		
	}
	
	/// Validate the input is correct. If not, an alert is shown and the method returns false.
	///
	/// - Returns: flag if the input is valid
	private func validate() -> Bool {
		
		if self.operation == .Delete {
			return true
		}
		
		if self.textNumber.stringValue.count == 0 {
			self.showOkMessage(title: "Input Needed", message: "Please enter the sequence number")
			return false
		}
		
		if self.textName.stringValue.count == 0 {
			self.showOkMessage(title: "Input Needed", message: "Please enter the name")
			return false
		}
		
		if self.textGiftIdeas.stringValue.count == 0 {
			self.showOkMessage(title: "Input Needed", message: "Please enter the gift ideas")
			return false
		}
		
		return true
	}
	
	/// Enable or disable view controls.
	///
	/// - Parameter isEnabled: flag if the controls should be enabled or not
	private func enableControls(isEnabled:Bool) {
		self.textNumber.isEnabled = isEnabled
		self.textName.isEnabled = isEnabled
		self.textAge.isEnabled = isEnabled
		self.buttonIsMale.isEnabled = isEnabled
		self.buttonIsHouseholdGift.isEnabled = isEnabled
		self.textGiftIdeas.isEnabled = isEnabled
		self.textOrganization.isEnabled = isEnabled
	}
    
}

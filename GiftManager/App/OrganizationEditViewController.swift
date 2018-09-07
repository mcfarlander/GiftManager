//
//  OrganizationEditViewController.swift
//  GiftManager
//
//  Created by David Johnson on 2/5/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Cocoa

/// The controller for performing a data operation on an Organization object.
class OrganizationEditViewController: NSViewController, NSTouchBarDelegate {
	
    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtPhone: NSTextField!
    
    @IBOutlet weak var btnOk: NSButton!
    @IBOutlet weak var btnCancel: NSButton!
	
	var delegate:SheetViewControllerDelegate?
	var organization:Organization? = nil
	var operation:DataOperation = DataOperation.Delete
	
	fileprivate let organizationDao = OrganizationDao()

	/// The view loaded.
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	/// The view appeared, perhaps after being closed.
	override func viewDidAppear() {
		
		txtName.stringValue = (self.organization?.name!)!.trim()
		txtPhone.stringValue = (self.organization?.phone!)!.trim()
		
		switch operation
		{
		case DataOperation.Add:
			txtName.isEnabled = true
			txtPhone.isEnabled = true
		case DataOperation.Update:
			txtName.isEnabled = true
			txtPhone.isEnabled = true
		case DataOperation.Delete:
			txtName.isEnabled = false
			txtPhone.isEnabled = false
		}
	}
	
	override func makeTouchBar() -> NSTouchBar? {
		
		let touchBarIdenitifier = NSTouchBar.CustomizationIdentifier(rawValue: "org.giftmanager.org.TouchBarRoute")
		let touchBarOkIdentifier = NSTouchBarItem.Identifier(rawValue: "org.giftmanager.org.Ok.button")
		let touchBarCancelIdentifier = NSTouchBarItem.Identifier(rawValue: "org.giftmanager.org.Cancel.button")
		
		let touchBar = NSTouchBar()
		touchBar.delegate = self
		touchBar.customizationIdentifier = touchBarIdenitifier
		touchBar.defaultItemIdentifiers = [touchBarOkIdentifier, touchBarCancelIdentifier, .fixedSpaceLarge, .otherItemsProxy]
		touchBar.customizationAllowedItemIdentifiers = [touchBarCancelIdentifier]
		
		return touchBar
	}
	
	func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
		
		if identifier.rawValue == "org.giftmanager.org.Ok.button" {
			let custom = NSCustomTouchBarItem(identifier: identifier)
			custom.customizationLabel = "OK"
			
			let label = NSTextField.init(labelWithString: "OK")
			custom.view = label
			
			return custom
			
		} else if identifier.rawValue == "org.giftmanager.org.Cancel.button" {
			
			let custom = NSCustomTouchBarItem(identifier: identifier)
			custom.customizationLabel = "Cancel"
			
			let label = NSTextField.init(labelWithString: "Cancel")
			custom.view = label
			
			return custom
			
		}
		
		return nil
		
	}
	
	/// Attempt to complate the data operation.
	///
	/// - Parameter sender: the view's button
    @IBAction func btnOk_Action(_ sender: NSButton) {
		
		if validate() {
			self.organization?.name = txtName.stringValue
			self.organization?.phone = txtPhone.stringValue
			
			switch self.operation
			{
			case .Add, .Update:
				self.organizationDao.update(organization: self.organization!)
			case .Delete:
				self.organizationDao.delete(organization: self.organization!)
			}
			
			self.delegate?.handleUpdate(isCanceled: false)
			self.dismiss(self)
		}
    }
	
	/// Cancel performing the data operation.
	///
	/// - Parameter sender: the view's button
	@IBAction func btnCancel_Action(_ sender: NSButton) {
		
		if self.operation == .Add {
			self.organizationDao.delete(organization: self.organization!)
		}
		
		self.delegate?.handleUpdate(isCanceled: true)
		self.dismiss(self)
	}
	
	/// Validate the input is correct. If not, an alert is shown and the method returns false.
	///
	/// - Returns: flag if the input is valid
	private func validate() -> Bool {
		
		if self.operation == .Delete {
			return true
		}
		
		if self.txtName.stringValue.count == 0 {
			self.showOkMessage(title: "Input Needed", message: "Please enter the organization name.")
			return false
		}
		
		if self.txtPhone.stringValue.count == 0 {
			self.showOkMessage(title: "Input Needed", message: "Please enter the phone number.")
			return false
		}
		
		return true
	}
}

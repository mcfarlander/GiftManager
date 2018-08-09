//
//  OrganizationEditViewController.swift
//  GiftManager
//
//  Created by David Johnson on 2/5/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Cocoa

class OrganizationEditViewController: NSViewController
{
    @IBOutlet weak var txtName: NSTextField!
    @IBOutlet weak var txtPhone: NSTextField!
    
    @IBOutlet weak var btnOk: NSButton!
    @IBOutlet weak var btnCancel: NSButton!
	
	var delegate:SheetViewControllerDelegate?
	var organization:Organization? = nil
	var operation:DataOperation = DataOperation.Delete
	
	fileprivate let organizationDao = OrganizationDao()

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
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
			
			self.delegate?.handleUpdate()
			self.dismiss(self)
		}
    }
	
	@IBAction func btnCancel_Action(_ sender: NSButton) {
		self.dismiss(self)
	}
	
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

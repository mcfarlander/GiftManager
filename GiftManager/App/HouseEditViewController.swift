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
				break
			case .Delete:
				break
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
		
		
		return true
	}
    
}

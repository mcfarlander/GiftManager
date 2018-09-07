//
//  RouteEditViewController.swift
//  GiftManager
//
//  Created by David Johnson on 2/5/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Cocoa

/// The controller for performing a data operation on a Route object.
class RouteEditViewController: NSViewController, NSTouchBarDelegate {
	
    @IBOutlet weak var txtRouteNumber: NSTextField!
    @IBOutlet weak var txtStreetName: NSTextField!
    
    @IBOutlet weak var btnOk: NSButton!
    @IBOutlet weak var btnCancel: NSButton!
	
	var delegate:SheetViewControllerDelegate?
    var route:Route? = nil
    var operation:DataOperation = DataOperation.Delete
	
	fileprivate let routeDao = RouteDao()
	
    /// The view loaded.
    override func viewDidLoad() {
		super.viewDidLoad()
    }
	
	/// The view appeared, perhaps after being closed.
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
	
	/// Creates the touchbar for this view.
	///
	/// - Returns: the new touchbar
	override func makeTouchBar() -> NSTouchBar? {
		
		let touchBarIdenitifier = NSTouchBar.CustomizationIdentifier(rawValue: "org.giftmanager.route.TouchBarRoute")
		let touchBarOkIdentifier = NSTouchBarItem.Identifier(rawValue: "org.giftmanager.route.Ok.button")
		let touchBarCancelIdentifier = NSTouchBarItem.Identifier(rawValue: "org.giftmanager.route.Cancel.button")
		
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
		
		if identifier.rawValue == "org.giftmanager.route.Ok.button" {
			let custom = NSCustomTouchBarItem(identifier: identifier)
			custom.customizationLabel = "OK"
			
			let label = NSTextField.init(labelWithString: "OK")
			custom.view = label
			
			return custom
			
		} else if identifier.rawValue == "org.giftmanager.route.Cancel.button" {
			
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
	
	/// Cancel performing the data operation.
	///
	/// - Parameter sender: the view's button
	@IBAction func btnCancel_Action(_ sender: NSButton) {
		
		if self.operation == .Add {
			self.routeDao.delete(route: self.route!)
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

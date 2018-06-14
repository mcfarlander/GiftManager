//
//  ViewControllerExtension.swift
//  GiftManager
//
//  Created by David Johnson on 12/9/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import Cocoa

extension NSViewController {
	// MARK: - General alert message dialog
	
	/**
	General ok dialog box (alert) for a message.
	- parameter title: The string to show as a bold title at the top of the dialog
	- parameter message: The string message to display as information to the user
	*/
	func showOkMessage(title:String, message:String) {
		let alert = NSAlert()
		alert.messageText = message
		alert.informativeText = title
		alert.alertStyle = .warning
		alert.addButton(withTitle: "OK")
		alert.runModal()
	}
	
}

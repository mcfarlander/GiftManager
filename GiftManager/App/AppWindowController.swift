//
//  AppWindowController.swift
//  GiftManager
//
//  Created by David Johnson on 12/10/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa

class AppWindowController: NSWindowController
{

	/// The notification that the touchbar add house button event happened.
	static let notificationAddHouse = Notification.Name("add.house")
	/// The notification that the touchbar add person button event happened.
	static let notificationAddPerson = Notification.Name("add.person")
	
    override func windowDidLoad()
    {
        NSLog("main winodw loaded")
        super.windowDidLoad()

    }
	@IBAction func AddHouse_Action(_ sender: NSButton) {
		NSLog("add house from touchbar")
		NotificationCenter.default.post(name: AppWindowController.notificationAddHouse, object: nil, userInfo:nil)
	}
	
	
	@IBAction func AddPerson_Action(_ sender: NSButton) {
		NSLog("add person from touchbar")
		NotificationCenter.default.post(name: AppWindowController.notificationAddPerson, object: nil, userInfo:nil)
	}
	
	
}

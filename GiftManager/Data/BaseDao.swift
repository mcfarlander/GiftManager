//
//  BaseDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import Cocoa
import CoreData

class BaseDao
{
	var manageObjectContext: NSManagedObjectContext? = nil
	
	init()
	{
		if manageObjectContext == nil
		{
			let appDelegate = NSApplication.shared.delegate as! AppDelegate
			manageObjectContext = appDelegate.managedObjectContext
		}
	}
	
}

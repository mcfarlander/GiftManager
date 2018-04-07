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


/// A class to contain the application managed data context.
class BaseDao
{
	
	/// The shared managed data context.
	var manageObjectContext: NSManagedObjectContext? = nil
	
	
	/// Creates a new instance of BaseDao.
	init()
	{
		if manageObjectContext == nil
		{
			let appDelegate = NSApplication.shared.delegate as! AppDelegate
			manageObjectContext = appDelegate.managedObjectContext
		}
	}
	
}

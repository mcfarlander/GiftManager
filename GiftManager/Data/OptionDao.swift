//
//  OptionDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/9/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

class OptionDao : BaseDao
{
	func list() -> [Option]?
	{
		var results: [Option]?
		
		do
		{
			let request: NSFetchRequest<Option> = Option.fetchRequest()
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
		
	}
	
	func create(key:String, value:String, note:String) -> Option?
	{
		do
		{
			let option = NSEntityDescription.insertNewObject(forEntityName: "Option", into: self.manageObjectContext!) as! Option
			
			option.key = key
			option.value = value
			option.note = note
			
			try option.managedObjectContext?.save()
			
			return option
			
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}
	
	func update(option:Option)
	{
		do
		{
			try option.managedObjectContext?.save()
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	func delete(option:Option)
	{
		do
		{
			self.manageObjectContext?.delete(option)
			try self.manageObjectContext?.save()
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in deleting \(error), \(error.userInfo)")
		}
		
	}
	
	func deleteAll()
	{
		if let objs = self.list()
		{
			for obj:Option in objs
			{
				delete(option: obj)
			}
		}
		
	}
	
}

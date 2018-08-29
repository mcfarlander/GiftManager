//
//  OptionDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/9/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation
import CoreData

/// DAO pattern class for the Option table.
class OptionDao : BaseDao {
	
	/// Get an array of all the options from the table.
	///
	/// - Returns: an array of Option objects mapped from the table
	func list() -> [Option]? {
		
		var results: [Option]?
		
		do {
			let request: NSFetchRequest<Option> = Option.fetchRequest()
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
			
		} catch let error as NSError {
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
	}
	
	/// Create an option record with the parameters.
	///
	/// - Parameters:
	///   - key: the key of the option
	///   - value: the value of the option
	///   - note: a note about how the option is to be used
	/// - Returns: the new option object from the table
	func create(key:String, value:String, note:String) -> Option? {
		
		do {
			let option = NSEntityDescription.insertNewObject(forEntityName: "Option", into: self.manageObjectContext!) as! Option
			
			option.key = key
			option.value = value
			option.note = note
			
			try option.managedObjectContext?.save()
			
			return option
			
		} catch let error as NSError {
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}
	
	/// Update the selected option record.
	///
	/// - Parameter option: the option to update
	func update(option:Option) {
		
		do {
			try option.managedObjectContext?.save()
			
		} catch let error as NSError {
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	/// Delete the selected option from the table.
	///
	/// - Parameter option: the option to delete
	func delete(option:Option) {
		
		do {
			self.manageObjectContext?.delete(option)
			try self.manageObjectContext?.save()
			
		} catch let error as NSError {
			NSLog("Unresolved error in deleting \(error), \(error.userInfo)")
		}
		
	}
	
	/// Delete all records from the options table.
	func deleteAll() {
		
		if let objs = self.list() {
			for obj:Option in objs {
				delete(option: obj)
			}
		}
	}
	
}

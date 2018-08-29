//
//  HouseDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation
import CoreData

/// DAO pattern class for the House table.
class HouseDao : BaseDao {
	
	/// Get an array of all Houses within the table.
	///
	/// - Returns: an array of houses mapped from the table
	func list() -> [House]? {
		
		var results: [House]?
		
		do {
			let request: NSFetchRequest<House> = House.fetchRequest()
			let sortDescriptor = NSSortDescriptor(key: "sequence", ascending: true)
			request.sortDescriptors = [sortDescriptor]
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
			
		} catch let error as NSError {
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
		
	}
	
	/// Get the next sequence for a new house based on the number of existing house records.
	///
	/// - Returns: the next sequence
	func getNextSequence() -> Int {
		return self.list()!.count + 1
	}
	
	/// Create a new house record with minimum parameters.
	///
	/// - Parameters:
	///   - sequence: the next sequence for the house
	///   - contact: the contact person's name within the house
	///   - phone: the phone number of the house
	/// - Returns: the new house record
	func create(sequence:Int, contact:String, phone:String) -> House? {
		
		do {
			let house = NSEntityDescription.insertNewObject(forEntityName: "House", into: self.manageObjectContext!) as! House
			
			house.sequence = Int32(sequence)
			house.contact = contact
			house.phone = phone
			
			try house.managedObjectContext?.save()
			
			return house
			
		} catch let error as NSError {
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
	}
	
	/// Create a new house in the table with minimal parameters.
	///
	/// - Parameters:
	///   - contact: the contact person's name within the house
	///   - phone: the phone number of the house
	/// - Returns: the new house record
	func create(contact:String, phone:String) -> House? {
		
		do {
			let house = NSEntityDescription.insertNewObject(forEntityName: "House", into: self.manageObjectContext!) as! House
			
			house.sequence = Int32(self.getNextSequence())
			house.contact = contact
			house.phone = phone
			
			try house.managedObjectContext?.save()
			
			return house
			
		} catch let error as NSError {
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
	}
	
	/// Update the selected House in the table.
	///
	/// - Parameter house: the house to update
	func update(house:House) {
		
		do {
			try house.managedObjectContext?.save()
			
		} catch let error as NSError {
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	/// Delete the selected House object from the table.
	///
	/// - Parameter house: the house to delete
	func delete(house:House) {
		
		do {
			self.manageObjectContext?.delete(house)
			try self.manageObjectContext?.save()
			
		} catch let error as NSError {
			NSLog("Unresolved error in deleting \(error), \(error.userInfo)")
		}
	}
	
	/// Delete all records from the House table.
	func deleteAll() {
		
		if let objs = self.list() {
			for obj:House in objs {
				delete(house: obj)
			}
		}
	}
}

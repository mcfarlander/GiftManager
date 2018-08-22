//
//  PersonDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

/// The DAO pattern class for the Person table.
class PersonDao : BaseDao {
	
	/// Get an array of all records from the persons table.
	///
	/// - Returns: array of Person objects
	func list() -> [Person]? {
		
		var results: [Person]?
		
		do {
			let request: NSFetchRequest<Person> = Person.fetchRequest()
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
		} catch let error as NSError {
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
		
	}
	
	/// Get a list of the persons in the house
	///
	/// - Parameter house: the house object
	/// - Returns: the list of persons in the selected house
	func list(house:House?)-> [Person]? {
		
		var results: [Person]?
		
		if let myHouse = house {
			do
			{
				let request: NSFetchRequest<Person> = Person.fetchRequest()
				request.returnsObjectsAsFaults = false
				request.predicate = NSPredicate(format: "(house = %@)", myHouse )
				
				try results = manageObjectContext?.fetch(request)
			}
			catch let error as NSError
			{
				NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
			}
		}
		
		return results

	}
	
	/// Get the next sequence within a house for a new person record.
	///
	/// - Parameter house: the house to query from
	/// - Returns: the next sequence to give a person record
	func getNextSequence(house:House) -> String {
		let count = self.list(house:house)?.count ?? 0
		return count.toString()
	}
	
	/// Create a person at the selected house with parameters.
	///
	/// - Parameters:
	///   - house: the house to add the person record to
	///   - sequence: the sequence within the house
	///   - name: the name of the person
	///   - ishousegift: flag if this person is a house-gift person
	///   - ismale: flag if male, false if female
	///   - age: the age of the person
	///   - giftIdeas: the person's gift ideas
	/// - Returns: the new person record
	func create(house:House, sequence:String, name:String, ishousegift:Bool, ismale:Bool, age:String, giftIdeas:String) -> Person? {
		
		do {
			let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: self.manageObjectContext!) as! Person
			
			person.house = house
			person.sequence = sequence
			person.name = name
			person.ishousegift = ishousegift
			person.ismale = ismale
			person.age = age
			person.giftideas = giftIdeas
			
			try person.managedObjectContext?.save()
			
			return person
			
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}
	
	/// Create a default person for the house.
	///
	/// - Parameter house: the house record to associate the person with
	/// - Returns: the person record created
	func create(house:House) -> Person? {
		
		let nextSequence = getNextSequence(house: house)
		var isHouseGift = false
		switch nextSequence
		{
		case "0":
			isHouseGift = true
		default:
			isHouseGift = false
		}
		
		return create(house: house, sequence: nextSequence, name: "", ishousegift: isHouseGift, ismale: false, age: "", giftIdeas: "")
		
	}
	
	/// Update the Person record.
	///
	/// - Parameter person: the record to update
	func update(person:Person) {
		
		do {
			try person.managedObjectContext?.save()
		} catch let error as NSError {
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	/// Delete the selected person record.
	///
	/// - Parameter person: the record to delete
	func delete(person:Person) {
		
		do {
			self.manageObjectContext?.delete(person)
			try self.manageObjectContext?.save()
		} catch let error as NSError {
			NSLog("Unresolved error in deleting \(error), \(error.userInfo)")
		}
		
	}
	
	/// Delete all records from the person table.
	func deleteAll() {
		
		if let objs = self.list() {
			for obj:Person in objs {
				delete(person: obj)
			}
		}
	}
	
}

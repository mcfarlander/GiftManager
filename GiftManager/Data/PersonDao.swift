//
//  PersonDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

class PersonDao : BaseDao
{
	func list() -> [Person]?
	{
		var results: [Person]?
		
		do
		{
			let request: NSFetchRequest<Person> = Person.fetchRequest()
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
		
	}
	
	/// Get a list of the persons in teh house
	///
	/// - Parameter house: the house object
	/// - Returns: the list of persons in the selected house
	func list(house:House?)-> [Person]?
	{
		var results: [Person]?
		
		if let myHouse = house
		{
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
	
	func getNextSequence(house:House) -> String
	{
		let count = self.list(house:house)?.count ?? 0
		return count.toString()
	}
	
	func create(house:House, sequence:String, name:String, ishousegift:Bool, ismale:Bool, age:String, giftIdeas:String) -> Person?
	{
		do
		{
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
	
	func create(house:House) -> Person?
	{
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
	
	func update(person:Person)
	{
		do
		{
			try person.managedObjectContext?.save()
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	func delete(person:Person)
	{
		do
		{
			self.manageObjectContext?.delete(person)
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
			for obj:Person in objs
			{
				delete(person: obj)
			}
		}
		
	}
	
}

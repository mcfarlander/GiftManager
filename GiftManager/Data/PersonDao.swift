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
	
	func list(house:House?)-> [Person]?
	{
		var results: [Person]?
		
		do
		{
			let request: NSFetchRequest<Person> = Person.fetchRequest()
			request.returnsObjectsAsFaults = false
			request.predicate = NSPredicate(format: "(house = %@)", house!)
			
			try results = manageObjectContext?.fetch(request)
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results

	}
	
	func getNextSequence(house:House) -> String
	{
		let count = self.list(house:house)?.count ?? 0
		
		switch count
		{
		case 0: return "0"
		case 1: return "A"
		case 2: return "B"
		case 3: return "C"
		case 4: return "D"
		case 5: return "E"
		case 6: return "F"
		case 7: return "G"
		case 8: return "H"
		case 9: return "I"
		case 10: return "J"
		case 11: return "K"
		case 12: return "L"
		case 13: return "M"
		case 14: return "N"
		case 15: return "O"
		case 16: return "P"
		case 17: return "R"
		case 18: return "S"
		case 19: return "T"
		case 20: return "U"
		default: return "0"
		}
		
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

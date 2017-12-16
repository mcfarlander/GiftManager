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
	
	func list(house:House)-> [Person]?
	{
		var results: [Person]?
		
		do
		{
			let request: NSFetchRequest<Person> = Person.fetchRequest()
			request.returnsObjectsAsFaults = false
			request.predicate = NSPredicate(format: "(house = %@)", house)
			
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
		if self.list(house:house) == 0
		{
			return "0"
		}
		else
		{
			
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

//
//  HouseDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

class HouseDao : BaseDao
{
	func list() -> [House]?
	{
		var results: [House]?
		
		do
		{
			let request: NSFetchRequest<House> = House.fetchRequest()
			let sortDescriptor = NSSortDescriptor(key: "sequence", ascending: true)
			request.sortDescriptors = [sortDescriptor]
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
		
	}
	
	func getNextSequence() -> Int
	{
		return self.list()!.count + 1
	}
	
	func create(sequence:Int, contact:String, phone:String) -> House?
	{
		do
		{
			let house = NSEntityDescription.insertNewObject(forEntityName: "House", into: self.manageObjectContext!) as! House
			
			house.sequence = Int32(sequence)
			house.contact = contact
			house.phone = phone
			
			try house.managedObjectContext?.save()
			
			return house
			
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}
	
	func create(contact:String, phone:String) -> House?
	{
		do
		{
			let house = NSEntityDescription.insertNewObject(forEntityName: "House", into: self.manageObjectContext!) as! House
			
			house.sequence = Int32(self.getNextSequence())
			house.contact = contact
			house.phone = phone
			
			try house.managedObjectContext?.save()
			
			return house
			
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}
	
	func update(house:House)
	{
		do
		{
			try house.managedObjectContext?.save()
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	func delete(house:House)
	{
		do
		{
			self.manageObjectContext?.delete(house)
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
			for obj:House in objs
			{
				delete(house: obj)
			}
		}
		
	}
	
}

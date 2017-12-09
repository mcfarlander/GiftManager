//
//  OrganizationDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

class OrganizationDao : BaseDao
{
	func list() -> [Organization]?
	{
		var results: [Organization]?
		
		do
		{
			let request: NSFetchRequest<Organization> = Organization.fetchRequest()
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
		
	}
	
	func create(name: String, phone:String) -> Organization?
	{
		do
		{
			let org = NSEntityDescription.insertNewObject(forEntityName: "Organization", into: self.manageObjectContext!) as! Organization
			
			org.name = name
			org.phone = phone
			
			try org.managedObjectContext?.save()
			
			return org
			
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}
	
	func update(organization:Organization)
	{
		do
		{
			try organization.managedObjectContext?.save()
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	
	func delete(organization:Organization)
	{
		do
		{
			self.manageObjectContext?.delete(organization)
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
			for obj:Organization in objs
			{
				delete(organization: obj)
			}
		}
		
	}
}

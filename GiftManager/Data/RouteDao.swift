//
//  RouteDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

class RouteDao : BaseDao
{
	func list() -> [Route]?
	{
		var results: [Route]?
		
		do
		{
			let request: NSFetchRequest<Route> = Route.fetchRequest()
			let sortDescriptor = NSSortDescriptor(key: "routenumber", ascending: true)
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
	
	func getRoute(routeNumber:String) -> Route?
	{
		var result:Route?
		
		for route:Route in self.list()!
		{
			if route.routenumber == routeNumber
			{
				result = route
			}
		}
		
		return result
	}
	
	func create(routeNumber: String, street:String) -> Route?
	{
		do
		{
			let route = NSEntityDescription.insertNewObject(forEntityName: "Route", into: self.manageObjectContext!) as! Route
			
			route.routenumber = routeNumber
			route.street = street
			
			try route.managedObjectContext?.save()
			
			return route
			
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}

	func update(route:Route)
	{
		do
		{
			try route.managedObjectContext?.save()
		}
		catch let error as NSError
		{
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	
	func delete(route:Route)
	{
		do
		{
			self.manageObjectContext?.delete(route)
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
			for obj:Route in objs
			{
				delete(route: obj)
			}
		}
		
	}

}

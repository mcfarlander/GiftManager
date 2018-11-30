//
//  RouteDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation
import CoreData

class RouteDao : BaseDao {
	
	/// Get an array of route objects from the table
	///
	/// - Returns: an array of route objects
	func list() -> [Route]? {
		
		var results: [Route]?
		
		do {
			let request: NSFetchRequest<Route> = Route.fetchRequest()
			let sortDescriptor = NSSortDescriptor(key: "routenumber", ascending: true)
			request.sortDescriptors = [sortDescriptor]
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
			
		} catch let error as NSError {
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
		
	}
	
	/// Get a route from it's number.
	///
	/// - Parameter routeNumber: the route number to query on
	/// - Returns: the route found by the query
	func getRoute(routeNumber:String) -> Route? {
		
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
	
	/// Create a new route with the parameters.
	///
	/// - Parameters:
	///   - routeNumber: the number of the route
	///   - street: the street on the route
	/// - Returns: the new route record object
	func create(routeNumber: String, street:String) -> Route? {
		
		do {
			let route = NSEntityDescription.insertNewObject(forEntityName: "Route", into: self.manageObjectContext!) as! Route
			
			route.routenumber = routeNumber
			route.street = street
			
			try route.managedObjectContext?.save()
			
			return route
			
		} catch let error as NSError {
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}

	/// Update the selected route record.
	///
	/// - Parameter route: the route to update
	func update(route:Route) {
		
		do {
			try route.managedObjectContext?.save()
			
		} catch let error as NSError {
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	/// Delete the selected route from the route table.
	///
	/// - Parameter route: the route to delete
	func delete(route:Route) {
		
		do {
			self.manageObjectContext?.delete(route)
			try self.manageObjectContext?.save()
			
		} catch let error as NSError {
			NSLog("Unresolved error in deleting \(error), \(error.userInfo)")
		}
	}
	
	/// Deletes all records from the route table.
	func deleteAll() {
		
		if let objs = self.list() {
			
			for obj:Route in objs {
				delete(route: obj)
			}
		}
	}

}

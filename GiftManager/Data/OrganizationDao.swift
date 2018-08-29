//
//  OrganizationDao.swift
//  GiftManager
//
//  Created by David Johnson on 12/8/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation
import CoreData

/// DAO pattern class for the organization table.
class OrganizationDao : BaseDao {
	
	/// Get a lit of all the organization records as an array.
	///
	/// - Returns: an array of Organization objects
	func list() -> [Organization]? {
		
		var results: [Organization]?
		
		do {
			let request: NSFetchRequest<Organization> = Organization.fetchRequest()
			request.returnsObjectsAsFaults = false
			
			try results = manageObjectContext?.fetch(request)
			
		} catch let error as NSError {
			NSLog("Unresolved error in fetch \(error), \(error.userInfo)")
		}
		
		return results
	}
	
	/// Get the organization record from it's name.
	///
	/// - Parameter name: the name to query on
	/// - Returns: the organization record with the selected name
	func getOrganization(name:String) -> Organization? {
		
		var result:Organization?
		
		for org:Organization in self.list()! {
			if org.name == name {
				result = org
			}
		}
		
		return result
	}
	
	/// Create an organization record with the parameters.
	///
	/// - Parameters:
	///   - name: the name of the organization
	///   - phone: the phone number of the organization
	/// - Returns: the new organization record object
	func create(name: String, phone:String) -> Organization? {
		
		do {
			let org = NSEntityDescription.insertNewObject(forEntityName: "Organization", into: self.manageObjectContext!) as! Organization
			
			org.name = name
			org.phone = phone
			
			try org.managedObjectContext?.save()
			
			return org
			
		} catch let error as NSError {
			NSLog("Unresolved error in adding \(error), \(error.userInfo)")
		}
		
		return nil
		
	}
	
	/// Update the selected organization record.
	///
	/// - Parameter organization: the organization to update
	func update(organization:Organization) {
		
		do {
			try organization.managedObjectContext?.save()
			
		} catch let error as NSError {
			NSLog("Unresolved error in updating \(error), \(error.userInfo)")
		}
	}
	
	/// Delete the selected organization from the table.
	///
	/// - Parameter organization: the organization to delete
	func delete(organization:Organization) {
		
		do {
			self.manageObjectContext?.delete(organization)
			try self.manageObjectContext?.save()
			
		} catch let error as NSError {
			NSLog("Unresolved error in deleting \(error), \(error.userInfo)")
		}
	}
	
	/// Delete all records from the organization table.
	func deleteAll() {
		
		if let objs = self.list() {
			for obj:Organization in objs {
				delete(organization: obj)
			}
		}
	}
}

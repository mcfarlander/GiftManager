//
//  CommonFetches.swift
//  GiftManager
//
//  Created by David Johnson on 11/15/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import AppKit
import Foundation
import CoreData


/**
 A class to contain various common fetch requests.
 */
class CommonFetches
{
    fileprivate var managedObjectContext: NSManagedObjectContext? = nil
    
    init()
    {
        // the context is loaded lazily. from any view with a fetch delegate, it'll
        // be populated. if not, get it from the application context
        
        //managedObjectContext = AppContext.managedObjectContext
        
        //if managedObjectContext == nil
        //{
            //let appDelegate = (NSApp.delegate as! AppDelegate)
            //managedObjectContext = appDelegate.managedObjectContext
        //}
        
        managedObjectContext = (NSApplication.shared().delegate as! AppDelegate).managedObjectContext
    }
    
    private func deleteAll(entity:String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do
        {
            try managedObjectContext?.execute(deleteRequest)
            try managedObjectContext?.save()
        }
        catch
        {
            NSLog("There was an error deleting all data from %@ error %@", entity, error.localizedDescription)
        }
        
    }
    
    func deleteAllOrganizations()
    {
        deleteAll(entity: "Organization")
    }

    func deleteAllRoutes()
    {
        deleteAll(entity: "Route")
    }
    
    func deleteAllHouesAndPersons()
    {
        deleteAll(entity: "House")
    }
    
    
}




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
    
    func mockData()
    {
        // 1. clear out all previous data
        deleteAllOrganizations()
        deleteAllRoutes()
        deleteAllHouesAndPersons()
        
        // 2. mock up 2 organizations
        let org1 = Organization()
        org1.name = "org1"
        org1.phone = "111-1111"
        
        let org2 = Organization()
        org2.name = "org2"
        org2.phone = "222-2222"
        
        // 3. mock up 2 routes
        let route1 = Route()
        route1.routenumber = "1"
        route1.street = "street1"
        
        let route2 = Route()
        route2.routenumber = "2"
        route2.street = "street2"
        
        // 4. create house with 2 people, attached to org1 and route1
        let house1 = House()
        house1.address = "1 north st"
        house1.contact = "contact 1"
        house1.deliver = false
        house1.phone = "phone1"
        house1.route = route1
        
        let person1 = Person()
        person1.sequence = "0"
        person1.ishousegift = true
        person1.giftideas = "person1 gifts"
        person1.organization = org1
        
        let person2 = Person()
        person2.sequence = "A"
        person2.ishousegift = false
        person2.giftideas = "person2 gifts"
        person2.age = 2
        person1.organization = org1
        
        house1.persons?.adding(person1)
        house1.persons?.adding(person2)
        
        // 5. create house with 1 person, attached to org2 and route2
        let house2 = House()
        house2.address = "2 north st"
        house2.contact = "contact 2"
        house2.deliver = false
        house2.phone = "phone2"
        house2.route = route2
        
        let person3 = Person()
        person3.sequence = "0"
        person3.ishousegift = true
        person3.giftideas = "person3 gifts"
        person3.organization = org2
        
        house2.persons?.adding(person3)
        
        // 6. commit data
        do
        {
            try managedObjectContext?.save()
        }
        catch
        {
            NSLog("There was an error mocking data error %@", error.localizedDescription)
        }
        
        
    }
    
    
}




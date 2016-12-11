//
//  Person.swift
//  GiftManager
//
//  Created by David Johnson on 11/15/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

class Person: NSManagedObject
{
    @NSManaged var age: NSNumber?
    @NSManaged var giftideas: String?
    @NSManaged var ishousegift: NSNumber?
    @NSManaged var ismale: NSNumber?
    @NSManaged var name: String?
    @NSManaged var sequence: String?
    
    @NSManaged var house: NSObject?
    @NSManaged var organization: NSObject?
    
}

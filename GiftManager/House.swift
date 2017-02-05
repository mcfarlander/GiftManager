//
//  House.swift
//  GiftManager
//
//  Created by David Johnson on 11/15/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

/**
 House represents an entity from the House table.
 */
class House: NSManagedObject
{
    @NSManaged var sequence: NSNumber?
    @NSManaged var address: String?
    @NSManaged var contact: String?
    @NSManaged var deliver: NSNumber?
    @NSManaged var notes: String?
    @NSManaged var phone: String?
    @NSManaged var printed: NSNumber?
    
    @NSManaged var persons: NSSet?
    @NSManaged var route: NSObject?
    
}

//
//  Organization.swift
//  GiftManager
//
//  Created by David Johnson on 11/15/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

/**
 Organization represents an entity from the Organization table.
 */
class Organization: NSManagedObject
{
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var persons: NSSet?
}

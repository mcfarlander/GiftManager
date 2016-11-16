//
//  Route.swift
//  GiftManager
//
//  Created by David Johnson on 11/15/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

/**
 Route represents an entity from the Route table.
 */
class Route: NSManagedObject
{
    @NSManaged var routenumber: String?
    @NSManaged var streat: String?
    @NSManaged var houses: NSSet?
}

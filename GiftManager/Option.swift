//
//  Option.swift
//  GiftManager
//
//  Created by David Johnson on 11/15/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

/**
 Option represents an entity from the Option table.
 */
class Option: NSManagedObject
{
    @NSManaged var key: String?
    @NSManaged var note: String?
    @NSManaged var value: String?
}

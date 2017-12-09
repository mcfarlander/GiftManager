//
//  Option+CoreDataProperties.swift
//  GiftManager
//
//  Created by David Johnson on 9/4/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData


extension Option {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Option> {
        return NSFetchRequest<Option>(entityName: "Option")
    }

    @NSManaged public var key: String?
    @NSManaged public var note: String?
    @NSManaged public var value: String?

}

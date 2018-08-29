//
//  Organization+CoreDataProperties.swift
//  GiftManager
//
//  Created by David Johnson on 9/4/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation
import CoreData


extension Organization {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Organization> {
        return NSFetchRequest<Organization>(entityName: "Organization")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var persons: Set<Person>?

}

// MARK: Generated accessors for persons
extension Organization {

    @objc(addPersonsObject:)
    @NSManaged public func addToPersons(_ value: Person)

    @objc(removePersonsObject:)
    @NSManaged public func removeFromPersons(_ value: Person)

    @objc(addPersons:)
    @NSManaged public func addToPersons(_ values: NSSet)

    @objc(removePersons:)
    @NSManaged public func removeFromPersons(_ values: NSSet)

}

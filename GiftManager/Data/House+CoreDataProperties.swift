//
//  House+CoreDataProperties.swift
//  GiftManager
//
//  Created by David Johnson on 9/4/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData


extension House {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<House> {
        return NSFetchRequest<House>(entityName: "House")
    }

    @NSManaged public var address: String?
    @NSManaged public var contact: String?
    @NSManaged public var deliver: Bool
    @NSManaged public var notes: String?
    @NSManaged public var phone: String?
    @NSManaged public var printed: Bool
    @NSManaged public var sequence: Int32
    @NSManaged public var persons: Set<Person>?
    @NSManaged public var route: Route?

}

// MARK: Generated accessors for persons
extension House {

    @objc(addPersonsObject:)
    @NSManaged public func addToPersons(_ value: Person)

    @objc(removePersonsObject:)
    @NSManaged public func removeFromPersons(_ value: Person)

    @objc(addPersons:)
    @NSManaged public func addToPersons(_ values: NSSet)

    @objc(removePersons:)
    @NSManaged public func removeFromPersons(_ values: NSSet)

}

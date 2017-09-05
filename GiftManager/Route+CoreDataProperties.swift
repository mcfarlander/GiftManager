//
//  Route+CoreDataProperties.swift
//  GiftManager
//
//  Created by David Johnson on 9/4/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation
import CoreData


extension Route {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Route> {
        return NSFetchRequest<Route>(entityName: "Route")
    }

    @NSManaged public var routenumber: String?
    @NSManaged public var street: String?
    @NSManaged public var houses: NSSet?

}

// MARK: Generated accessors for houses
extension Route {

    @objc(addHousesObject:)
    @NSManaged public func addToHouses(_ value: House)

    @objc(removeHousesObject:)
    @NSManaged public func removeFromHouses(_ value: House)

    @objc(addHouses:)
    @NSManaged public func addToHouses(_ values: NSSet)

    @objc(removeHouses:)
    @NSManaged public func removeFromHouses(_ values: NSSet)

}

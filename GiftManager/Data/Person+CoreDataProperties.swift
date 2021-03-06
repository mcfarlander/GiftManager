
//
//  Person+CoreDataProperties.swift
//  GiftManager
//
//  Created by David Johnson on 9/4/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: String?
    @NSManaged public var giftideas: String?
    @NSManaged public var ishousegift: Bool
    @NSManaged public var ismale: Bool
    @NSManaged public var name: String?
    @NSManaged public var sequence: String?
    @NSManaged public var house: House?
    @NSManaged public var organization: Organization?

}

//
//  CommonFetches.swift
//  GiftManager
//
//  Created by David Johnson on 11/15/16.
//  Copyright © 2016 David Johnson. All rights reserved.
//

import AppKit
import Foundation
import CoreData

/**
 A class to contain various common fetch requests.
 */
class CommonFetches
{
	fileprivate let routeDao = RouteDao()
	fileprivate let organizationDao = OrganizationDao()
	fileprivate let houseDao = HouseDao()
	fileprivate let personDao = PersonDao()

    // MARK: - Mock Data
	
	
    /// Mock data will delete all data in organizations, routes, houses and persons tables.
	/// It will add some fake data for UI testing.
    func mockData() {
        NSLog("mocking data")

		// 1. clear out all previous data
		self.organizationDao.deleteAll()
		self.routeDao.deleteAll()
		self.houseDao.deleteAll()
		self.personDao.deleteAll()

		// 2. mock up 2 organizations
		let _ = self.organizationDao.create(name: "org1", phone: "111-1111")
		let _ = self.organizationDao.create(name: "org2", phone: "222-2222")
        
		// 3. mock up 2 routes
		let _ = self.routeDao.create(routeNumber: "1", street: "street1")
		let _ = self.routeDao.create(routeNumber: "2", street: "street2")


		// 4. create house with 2 people, attached to org1 and route1
		let house1 = houseDao.create(sequence: 1, contact: "contact1", phone: "phone1")
		let house2 = houseDao.create(sequence: 2, contact: "contact2", phone: "phone2")
			
		let _ = personDao.create(house: house1!, sequence: "0", name: "", ishousegift: true, ismale: false, age: "", giftIdeas: "person0 gifts")
		let _ = personDao.create(house: house1!, sequence: "1", name: "1", ishousegift: false, ismale: false, age: "1", giftIdeas: "person1 gifts")
			
		let _ = personDao.create(house: house2!, sequence: "0", name: "", ishousegift: true, ismale: false, age: "", giftIdeas: "person0 gifts")

        
    }
    
    
}

//
//  CvsMasterList.swift
//  GiftManager
//
//  Created by Dave on 11/18/18.
//  Copyright © 2018 org.djohnson. All rights reserved.
//

import Foundation

/// Create a CSV file with all the information identical to the master list pdf report.
/// example of items in the file:
///  "93-0","Household Gift","","Pick 'n Save Gift Card"
///  "93-1","Male","16","Large sweatshirt"
class CsvMasterList {
	
	fileprivate let houseDao = HouseDao()
	private let personDao = PersonDao()
	let csvExport = CsvExport()
	
	fileprivate let FILE_NAME = "master_list"
	fileprivate let FILE_EXT = ".csv"
	
	fileprivate let header = ["Tag", "Tag2", "Address", "Phone", "Org", "Name", "Age", "Gender", "Gifts"]
	fileprivate let HOUSEHOLD_GIFT = "Household Gift"
	fileprivate let HOUSEHOLD_AGE = ""
	fileprivate let DASH = "-"
	
	/// Acquire data from and create the CSV file.
	func createCvsForMasterList() {
		
		let fileName = self.FILE_NAME + "-" + DateUtils.formatDateYyyyMMdd(timestamp: Date()) + self.FILE_EXT
		self.csvExport.setPath(path: fileName)
		
		self.csvExport.convertAndAppendLines(items: self.header, useQuotes: true)
		
		for house:House in self.houseDao.list()! {
			
			let houseId:String = house.sequence.toString()
			var address = house.address ?? ""
			let contact = house.contact ?? ""
			
			let people = self.personDao.list(house: house)!
			
			for person:Person in people {
				
				var phone:String = house.phone ?? ""
				
				var org:String = ""
				if let selectedOrg = person.organization {
					org = selectedOrg.name ?? ""
				}
				
				let personId:String = person.sequence ?? ""
				let tagId = houseId + DASH + personId
				let tagIdHidden = HouseUtils.formatHousePersonIdNNHH(houseId: houseId, personId: personId)
				
				var personName: String = person.name ?? ""
				
				let age:String = person.age ?? ""
				
				var gender = "F"
				if person.ismale {
					gender = "M"
				}
				
				if personId != "0" {
					address = ""			// don't show the address and phone for the dependants
					phone = ""
				} else {
					personName = contact	// for the household, show the contact
					gender = ""				// for the household, no gender
				}
				
				let gift = person.giftideas ?? ""
				
				let row:[String] = [tagId, tagIdHidden, address, phone, org, personName, age, gender, gift]
				self.csvExport.convertAndAppendLines(items: row, useQuotes: true)
			}
			
		}
		
		self.csvExport.writeCsv()
		
	}

}

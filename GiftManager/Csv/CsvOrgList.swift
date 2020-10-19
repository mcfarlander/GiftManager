//
//  CsvOrgList.swift
//  GiftManager
//
//  Created by David Johnson on 10/19/20.
//  Copyright © 2020 org.djohnson. All rights reserved.
//

import Foundation


/// Create a CSV file with all the information for an organization.
/// example of items in the file:
///  "93-0","ucc", "Household Gift","","Pick 'n Save Gift Card"
///  "93-1","ucc", "Male","16","Large sweatshirt"
class CsvOrgList {
	
	fileprivate let houseDao = HouseDao()
	let csvExport = CsvExport()
	
	fileprivate let FILE_NAME = "org_list"
	fileprivate let FILE_EXT = ".csv"
	
	fileprivate let header = ["TAGID", "ORG", "GENDER", "AGE", "IDEAS"]
	fileprivate let HOUSEHOLD_GIFT = "Household Gift"
	fileprivate let HOUSEHOLD_AGE = ""
	fileprivate let DASH = "-"

	
	/// Acquire data from and create the CSV file.
	func createCvsForOrganizations() {
		
		let fileName = self.FILE_NAME + "-" + DateUtils.formatDateYyyyMMdd(timestamp: Date()) + self.FILE_EXT
		self.csvExport.setPath(path: fileName)
		
		self.csvExport.convertAndAppendLines(items: self.header, useQuotes: true)
		
		for house:House in self.houseDao.list()! {
			for person:Person in house.persons! {
				let tagId = house.sequence.toString() + self.DASH + person.sequence!
				
				var org = ""
				
				if let organization = person.organization {
					org = organization.name ?? ""
				}
				
				var gender = person.ismale ? "Male" : "Female"
				var age = person.age!
				
				if person.ishousegift {
					gender = self.HOUSEHOLD_GIFT
					age = self.HOUSEHOLD_AGE
				}
				
				let gift = person.giftideas!
				
				let item:[String] = [tagId, org, gender, age, gift]
				self.csvExport.convertAndAppendLines(items: item, useQuotes: true)
				
			}
			
		}
		
		self.csvExport.writeCsv()
		
	}
	
}

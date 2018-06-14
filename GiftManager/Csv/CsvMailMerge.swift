//
//  CvsMailMerge.swift
//  GiftManager
//
//  Created by Dave on 12/31/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation


/// Create a CSV file with all the information to perform a mail merge.
/// example of items in the file:
///  "93-0","Household Gift","","Pick 'n Save Gift Card"
///  "93-1","Male","16","Large sweatshirt"
class CsvMailMerge
{
	fileprivate let houseDao = HouseDao()
	let csvExport = CsvExport()
	
	fileprivate let FILE_NAME = "mail_merge"
	fileprivate let FILE_EXT = ".csv"
	
	fileprivate let header = ["TAGID","GENDER","AGE","IDEAS"]
	fileprivate let HOUSEHOLD_GIFT = "Household Gift"
	fileprivate let HOUSEHOLD_AGE = ""
	fileprivate let DASH = "-"

	
	/// Acquire data from and create the CSV file.
	func createCvsForMailMerge() {
		
		let fileName = self.FILE_NAME + "-" + DateUtils.formatDateYyyyMMdd(timestamp: Date()) + self.FILE_EXT
		self.csvExport.setPath(path: fileName)
		
		self.csvExport.convertAndAppendLines(items: self.header, useQuotes: true)
		
		for house:House in self.houseDao.list()! {
			for person:Person in house.persons! {
				let tagId = house.sequence.toString() + self.DASH + person.sequence!
				
				var gender = person.ismale ? "Male" : "Female"
				var age = person.age!
				
				if person.ishousegift {
					gender = self.HOUSEHOLD_GIFT
					age = self.HOUSEHOLD_AGE
				}
				
				let gift = person.giftideas!
				
				let item:[String] = [tagId, gender, age, gift]
				self.csvExport.convertAndAppendLines(items: item, useQuotes: true)
				
			}
			
		}
		
		self.csvExport.writeCsv()
		
	}
	
}

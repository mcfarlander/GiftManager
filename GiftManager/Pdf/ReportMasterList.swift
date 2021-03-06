//
//  ReportMasterList.swift
//  GiftManager
//
//  Created by David Johnson on 4/15/18.
//  Copyright © 2018 David Johnson. All rights reserved.
//

import Foundation
import Cocoa

/// An implementation of ReportProtocol to create the master list report.
class ReportMasterList {
	
	let report = ReportBase()
	private let houseDao = HouseDao()
	private let personDao = PersonDao()
	
	/// Generate a CSV file with the houses and persons.
	///
	/// - Returns: the path where the file was saved to
	func generateMasterListReport() -> String? {
		
		let titles = ["House", "Address", "Phone", "Route", "Person", "Name", "Age", "Gender"]
		let blankRow = ["", "", "", "", "", "", "", ""]
		
		report.createHeader(title: "Master List", name: "MasterList", reportDescrption: "Master List of People")
		report.createTable(columnTitles: titles)
		
		for house:House in self.houseDao.list()! {
			let people = self.personDao.list(house: house)!
			
			for person:Person in people {
				let houseId:String = house.sequence.toString()
				var phone:String = house.phone ?? ""
				
				var houseRoute:String = ""
				if let route = house.route {
					houseRoute = route.routenumber ?? ""
				}
				
				let personId:String = person.sequence ?? ""
				
				// don't show the phone for the dependants
				if personId != "0" {
					phone = ""
				}
				
				let personName: String = person.name ?? ""
				let age:String = person.age ?? ""
				
				var gender = "F"
				if person.ismale {
					gender = "M"
				}
				
				let row:[String] = [houseId, "", phone, houseRoute, personId, personName, age, gender]
				report.createTableRow(columnValues: row)
			}
			
			report.createTableRow(columnValues: blankRow, rowColor: NSColor.gray)
			
		}
		
		report.endTable()
		report.createFooter()
		return report.saveReportPdf()
	
	}
	
}

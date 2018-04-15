//
//  ReportMasterList.swift
//  GiftManager
//
//  Created by Dave on 4/15/18.
//  Copyright © 2018 org.djohnson. All rights reserved.
//

import Foundation
import Cocoa

class ReportMasterList
{
	
	private let report = ReportBase()
	private let houseDao = HouseDao()
	private let personDao = PersonDao()
	
	func generateMasterListReport() -> String?
	{
		let titles = ["House", "Address", "Phone", "Route", "Person", "Name", "Age", "Gender"]
		let blankRow = ["", "", "", "", "", "", "", ""]
		
		report.createHeader(title: "Master List", name: "MasterList", reportDescrption: "Master List of People")
		report.createTable(columnTitles: titles)
		
		report.createTableRow(columnValues: blankRow, rowColor: NSColor.gray)
		
		for house:House in self.houseDao.list()!
		{
			let people = self.personDao.list(house: house)!
			
			for person:Person in people
			{
				let houseId:String = house.sequence.toString()
				let phone:String = house.phone ?? ""
				
				var houseRoute:String = ""
				if let route = house.route
				{
					houseRoute = route.routenumber ?? ""
				}
				
				let personId:String = person.sequence ?? ""
				let personName: String = person.name ?? ""
				let age:String = person.age ?? ""
				
				var gender = "F"
				if person.ismale
				{
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

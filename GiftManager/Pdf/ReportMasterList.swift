//
//  ReportMasterList.swift
//  GiftManager
//
//  Created by Dave on 4/15/18.
//  Copyright © 2018 org.djohnson. All rights reserved.
//

import Foundation

class ReportMasterList
{
	
	private let report = ReportBase()
	private let houseDao = HouseDao()
	private let personDao = PersonDao()
	
	func generateReport()
	{
		
		report.createHeader(title: "Master List", name: "MasterList", reportDescrption: "Master List of People")
		
	
	
	}
	
}

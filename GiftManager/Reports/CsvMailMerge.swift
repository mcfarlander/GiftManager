//
//  CvsMailMerge.swift
//  GiftManager
//
//  Created by Dave on 12/31/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation

class CsvMailMerge
{
	fileprivate let houseDao = HouseDao()
	fileprivate let csvExport = CsvExport()
	
	func createCvsForMailMerge()
	{
		self.csvExport.delegate = self
		
		
		
	}
	
}

extension CsvMailMerge: CsvExportDelegate
{
	func handleWroteCsv(success:Bool, filePath:String, errorMessage:String)
	{
		
	}
}

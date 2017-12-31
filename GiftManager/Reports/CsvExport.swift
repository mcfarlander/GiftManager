//
//  CvsExport.swift
//  GiftManager
//
//  Created by Dave on 12/30/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation

protocol CsvExportDelegate
{
	func handleWroteCsv(success:Bool, filePath:String, errorMessage:String)
}

/**
 A customer class to export data to a CSV file.
 */
class CsvExport
{
	fileprivate var path:String = ""
	fileprivate var separator:String = ","
	fileprivate var lines:[String] = [""]
	
	var delegate:CsvExportDelegate?
	
	init() { }
	
	init(path:String)
	{
		self.path = path
	}
	
	/** Set the file path where the CSV file will be written to. */
	func setPath(path:String) { self.path = path }
	
	/** Set the separator between items. Defaults to a comma. */
	func setSeparator(separator:String) { self.separator = separator }
	
	/** Add a line to the file. No conversion of items is made. */
	func appendLine(line:String) { self.lines.append(line) }
	
	/** Convert an array of strings to a single line, ready to be appended. */
	func convertToLine(strings:[String], isHeader:Bool) -> String
	{
		var contents = ""
		
		for item:String in strings
		{
			if isHeader
			{
				contents.append("\"")
			}
			
			contents.append(item)
			
			if isHeader
			{
				contents.append("\"")
			}
			
			contents.append(self.separator)

		}
		
		contents = String(contents.dropLast())
		contents.append("\n")

		return contents
		
	}
	
	/** Convert an array of strings to a single line and appends it to the array of lines immediately. */
	func convertAndAppendLines(items:[String], isHeader:Bool)
	{
		let line = convertToLine(strings: items, isHeader: isHeader)
		self.appendLine(line: line)
	}
	
	/** Write the array of lines to file. */
	func writeCsv()
	{
		let urlPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(self.path)
		var csvText = ""
		
		for line in self.lines
		{
			csvText.append(line)
		}
		
		do
		{
			try csvText.write(to: urlPath!, atomically: true, encoding: String.Encoding.utf8)
			self.delegate?.handleWroteCsv(success: true, filePath: (urlPath?.absoluteString)!, errorMessage: "")
		}
		catch
		{
			self.delegate?.handleWroteCsv(success: false, filePath: "", errorMessage: "\(error)")
		}
		
	}

	
}

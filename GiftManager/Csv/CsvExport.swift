//
//  CvsExport.swift
//  GiftManager
//
//  Created by Dave on 12/30/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation

/**
 A customer class to export data to a CSV file.
 */
class CsvExport
{
	fileprivate var path:String = ""
	fileprivate var separator:String = ","
	fileprivate var lines:[String] = [""]
	
	var delegate:FileCreationDelegate?
	
	init() { }
	
	init(path:String) {
		self.path = path
	}
	
	/** Set the file path where the CSV file will be written to. */
	func setPath(path:String) { self.path = path }
	
	/** Set the separator between items. Defaults to a comma. */
	func setSeparator(separator:String) { self.separator = separator }
	
	/** Add a line to the file. No conversion of items is made. */
	func appendLine(line:String) { self.lines.append(line) }
	
	/** Convert an array of strings to a single line, ready to be appended. */
	func convertToLine(strings:[String], useQuotes:Bool) -> String {
		var contents = ""
		
		for item:String in strings {
			if useQuotes {
				contents.append("\"")
			}
			
			contents.append(item)
			
			if useQuotes {
				contents.append("\"")
			}
			
			contents.append(self.separator)

		}
		
		contents = String(contents.dropLast())
		contents.append("\n")

		return contents
		
	}
	
	/** Convert an array of strings to a single line and appends it to the array of lines immediately. */
	func convertAndAppendLines(items:[String], useQuotes:Bool) {
		let line = convertToLine(strings: items, useQuotes: useQuotes)
		self.appendLine(line: line)
	}
	
	/** Write the array of lines to file on desktop. */
	func writeCsv() {
		let urlPath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Desktop").appendingPathComponent(self.path)
		var csvText = ""
		
		for line in self.lines {
			csvText.append(line)
		}
		
		do {
			try csvText.write(to:urlPath, atomically: false, encoding: .utf8)
			self.delegate?.handleWroteFile(success: true, filePath: urlPath.absoluteString, errorMessage: "")
		} catch {
			self.delegate?.handleWroteFile(success: false, filePath: "", errorMessage: "\(error)")
		}
		
	}
	
}

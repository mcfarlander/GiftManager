//
//  CvsExport.swift
//  GiftManager
//
//  Created by David Johnson on 12/30/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation

/// A customer class to export data to a CSV file.
class CsvExport {

	fileprivate var path:String = ""
	fileprivate var separator:String = ","
	fileprivate var lines:[String] = [""]
	
	var delegate:FileCreationDelegate?
	
	/// Create a new instance of CsvExport.
	init() { }
	
	/// Create a new instance of CsvExport.
	///
	/// - Parameter path: the path where the csv file will reside.
	init(path:String) {
		self.path = path
	}

	/// Set the file path where the CSV file will be written to.
	///
	/// - Parameter path: the path to use
	func setPath(path:String) { self.path = path }

	/// Set the separator between items. Defaults to a comma.
	///
	/// - Parameter separator: the separator to use
	func setSeparator(separator:String) { self.separator = separator }
	
	/// Add a line to the file. No conversion of items is made.
	///
	/// - Parameter line: the line of text to add
	func appendLine(line:String) { self.lines.append(line) }
	
	/// Convert an array of strings to a single line, ready to be appended.
	///
	/// - Parameters:
	///   - strings: the array of string to merge into a single string
	///   - useQuotes: if the merged strings should be quoted
	/// - Returns: the single string
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
	
	/// Convert an array of strings to a single line and appends it to the array of lines immediately.
	///
	/// - Parameters:
	///   - items: the array of string to merge into one
	///   - useQuotes: flag if all the strings should be quoted
	func convertAndAppendLines(items:[String], useQuotes:Bool) {
		let line = convertToLine(strings: items, useQuotes: useQuotes)
		self.appendLine(line: line)
	}
	

	/// Write the array of lines to file on desktop.
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

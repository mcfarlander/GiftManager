//
//  ReportProtocol.swift
//  GiftManager
//
//  Created by David Johnson on 1/16/18.
//  Copyright © 2018 David Johnson. All rights reserved.
//

import Foundation
import Cocoa

/// Reporting protocol. Each subclass must implement these methods.
protocol ReportProtocol {
	
	/**
	Clients must set the report's name, which will also be
	the file name when the html is saved to file.
	
	- parameter name: the new report name
	*/
	func setReportName(name: String)
	
	/**
	Clients must set the report title, to be displayed within the html.
	
	- parameter title: the new report title
	*/
	func setReportTitle(title: String)
	
	/**
	Clients must set the report description.
	
	- parameter descr:  the new report description
	*/
	func setReportDescription(descr: String)
	
	/**
	Returns the string buffer generated by client classes,
	which could be passed directly to a ui browser object
	rather than saving to disk and feeding the ui browser
	a uri.
	
	- returns: the buffer as a string
	*/
	func getBuffer() -> String
	
	
	/**
	Automatically generates an html header, places the description and creates an
	html table, to be finished by createFooter.
	*/
	func createHeader()
	
	/**
	Automatically generates an html header, places the description and creates an
	html table, to be finished by createFooter.
	- parameter title: the new report name
	*/
	func createHeader(title:String)
	
	/// Create the html table heaer
	///
	/// - Parameters:
	///   - title: the title of the report
	///   - name: the name of the report
	///   - reportDescrption: the description of the report
	func createHeader(title:String, name:String, reportDescrption:String)

	/// Create a table for with the column header values
	///
	/// - Parameter columnTitles: an array of values to put in each column
	func createTable(columnTitles:[String])
	
	/// Create a table row with the column values
	///
	/// - Parameter columnValues: an arrya of values to put in each column
	func createTableRow(columnValues:[String])
	
	/// Create a table row with the column values and set the background color
	///
	/// - Parameters:
	///   - columnValues: an arrya of values to put in each column
	///   - rowColor: the background color of the row
	func createTableRow(columnValues:[String], rowColor:NSColor)
	
	/// Finish the html table
	///
	func endTable()
	
	/**
	Automatically finishes the html table and file started by createHeader.
	*/
	func createFooter()
	
	/**
	Method to be implemented to save the html to file.
	
	- returns: the string path
	*/
	func saveReport() -> String
	
	/**
	Method to be implemented to save the html to file as pdf.
	
	- returns: the string path
	*/
	func saveReportPdf() -> String
	
}

//
//  ReportBase.swift
//  GiftManager
//
//  Created by David Johnson on 1/20/18.
//  Copyright © 2018 David Johnson. All rights reserved.
//

import Foundation
import Cocoa
import WebKit

/// Report base implements ReportProtocol.
/// General guidelines:
/// 	let report = ReportBase()
/// 	report.report.createHeader(title: "My title", name: "My name", reportDescrption: "My description")
/// 	report.createTable(["Col1", "Col2"])
/// 	report.createTableRow(["Val1", "Val3"])
/// 	report.endTable()
/// 	report.createFooter()
/// 	report.saveReportPdf()
class ReportBase : ReportProtocol
{
	/// The m_report name.
	private var m_reportName = ""
	
	/// The m_report title.
	private var m_reportTitle = ""
	
	/// The m_report description.
	private var m_reportDescription = ""
	
	///The m_buffer.
	private var m_buffer = ""
	
	/// The delegate to inform clients the file has been created and if there was a problem.
	var delegate:FileCreationDelegate?
	
	/// Set the report name.
	///
	/// - Parameter name: the name for the report
	func setReportName(name:String){ m_reportName = name }

	/// Gets the report name.
	///
	/// - Returns: the report's name
	func getReportName()-> String { return m_reportName }
	
	/// Set the report's title.
	///
	/// - Parameter title: the new title of the report
	func setReportTitle(title: String) { m_reportTitle = title }
	
	/// Set the report description
	///
	/// - Parameter descr: the report description
	func setReportDescription(descr: String) { m_reportDescription = descr }
	
	/// Get the string buffer, which is the report textual contents.
	///
	/// - Returns: the report contents as a string
	func getBuffer() -> String { return m_buffer; }
	
	/// Default constructor.
	init(){}

	/// Overloaded constructor to set the name (also file name), title and description used within the html.
	///
	/// - Parameters:
	///   - name: the name of the report
	///   - title: the title to appear in the report
	///   - description: the description of the report
	init (name:String, title:String, description:String) {
		self.m_reportName = name
		self.m_reportTitle = title
		self.m_reportDescription = description
	}
	
	/// Implementation of IReportBase.createHeader().
	func createHeader() {
		
		m_buffer.append("<html>")
		m_buffer.append("<head>")
		
		let title = "<title>" + self.m_reportName + "</title>"
		m_buffer.append(title)
		
		m_buffer.append("</head>")
		
		m_buffer.append("<body>")
		
		m_buffer.append("<H2>")
		m_buffer.append(self.m_reportTitle)
		m_buffer.append("</H2>")
		m_buffer.append("<br>")
		m_buffer.append(m_reportDescription)
		m_buffer.append("<br> <br>")
		
	}
	
	/// Create the hmtl table header
	///
	/// - Parameter title: the title of the report
	func createHeader(title:String) {
		self.m_reportTitle = title
		createHeader()
	}
	
	/// Create the html table heaer
	///
	/// - Parameters:
	///   - title: the title of the report
	///   - name: the name of the report
	///   - reportDscrption: the description of the report
	func createHeader(title:String, name:String, reportDescrption:String) {
		self.m_reportName = name
		self.m_reportTitle = title
		self.m_reportDescription = reportDescrption
		createHeader()
	}
	
	/// Create a table for with the column header values
	///
	/// - Parameter columnTitles: an array of values to put in each column
	func createTable(columnTitles:[String]) {
		m_buffer.append("<br>")
		m_buffer.append("<table border='1' cellpadding='2' width='80%' style='margin:0px auto'>")
		m_buffer.append("<tr>")
		
		for title in columnTitles {
			m_buffer.append("<th>")
			m_buffer.append(title)
			m_buffer.append("</th>")
		}
		
		m_buffer.append("</tr>")
		
	}
	
	/// Create a table row with the column values
	///
	/// - Parameter columnValues: an arrya of values to put in each column
	func createTableRow(columnValues:[String]) {
		createTableRow(columnValues:columnValues, rowColor:NSColor.white)
	}
	
	/// Create a table row with the column values and set the background color
	///
	/// - Parameters:
	///   - columnValues: an arrya of values to put in each column
	///   - rowColor: the background color of the row
	func createTableRow(columnValues:[String], rowColor:NSColor) {
		var rowString = ""
		
		if let hex = rowColor.toHex() {
			rowString.append("<tr style='background-color:" + hex + "' >")
		} else {
			rowString.append("<tr>")
		}
		
		for columnValue in columnValues {
			rowString.append("<td>")
			rowString.append(columnValue)
			rowString.append("</td>")
		}
		
		rowString.append("</tr>")
		
		self.m_buffer.append(rowString)
		
	}
	
	/// Finish the html table
	func endTable() {
		m_buffer.append("</table>")
		m_buffer.append("<br>")
	}
	
	/// Implementation of IReportBase.createFooter.
	func createFooter() {
		m_buffer.append("</body>")
		m_buffer.append("</html>")
	}

	/// Implementation of IReportBase.saveReport. Takes the report's name and saves it to the user's desktop path.
	///
	/// - Returns: the path where the file was saved to
	func saveReport() -> String {
		let dateCode = DateUtils.formatDateYyyyMMddNoDash(timestamp: Date())
		let fileName = self.m_reportName + "_" + dateCode + ".html"
		var sReturn = ""
		
		let urlPath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Desktop").appendingPathComponent(fileName)

		do {
			try self.m_buffer.write(to:urlPath, atomically: false, encoding: .utf8)
			sReturn = fileName
			self.delegate?.handleWroteFile(success: true, filePath: sReturn, errorMessage: "")
		} catch {
			NSLog("\(error)")
			self.delegate?.handleWroteFile(success: false, filePath: sReturn, errorMessage: error.localizedDescription)
		}
		
		return sReturn
		
	}

	/// Implementation of IReportBase.saveReportPdf. Takes the report and saves it to user's desktop path.
	///
	/// - Returns: the path the file was saved to
	func saveReportPdf() -> String {
		
		let dateCode = DateUtils.formatDateYyyyMMddNoDash(timestamp: Date())
		let fileName = self.m_reportName + "_" + dateCode + ".pdf"
		let urlPath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Desktop").appendingPathComponent(fileName)
		
		let webView = WKWebView()
		webView.loadHTMLString(self.getBuffer(), baseURL: nil)
		let when = DispatchTime.now() + 2
		
		DispatchQueue.main.asyncAfter(deadline: when) {
			
			let printOpts: [NSPrintInfo.AttributeKey: Any] = [NSPrintInfo.AttributeKey.jobDisposition: NSPrintInfo.JobDisposition.save, NSPrintInfo.AttributeKey.jobSavingURL: urlPath]
			
			let printInfo = NSPrintInfo(dictionary: printOpts)
			printInfo.horizontalPagination = NSPrintInfo.PaginationMode.automatic
			printInfo.verticalPagination = NSPrintInfo.PaginationMode.automatic
			printInfo.topMargin = 10.0
			printInfo.leftMargin = 10.0
			printInfo.rightMargin = 10.0
			printInfo.bottomMargin = 10.0

			let printOp: NSPrintOperation = NSPrintOperation(view: (webView.enclosingScrollView?.documentView)!, printInfo: printInfo)
			printOp.showsPrintPanel = false
			printOp.showsProgressPanel = false
			let success = printOp.run()
			
			if success {
				self.delegate?.handleWroteFile(success: true, filePath: fileName, errorMessage: "")
			} else {
				self.delegate?.handleWroteFile(success: false, filePath: "", errorMessage: "There was a problem writing the file.")
			}
		}
		
		return fileName
		
	}
	
}

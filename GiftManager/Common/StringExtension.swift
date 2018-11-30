//
//  StringExtension.swift
//  GiftManager
//
//  Created by David Johnson on 12/9/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation
import Cocoa


extension String {
	
	/// Trim front and back whitespace.
	///
	/// - Returns: The same string with spaces remove in front and back
	func trim() -> String {
		return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
	}
	
	/// Converts a string to an encoded base 64 string.
	///
	/// - Returns: the base 64 version of the string
	func toBase64() -> String {
		return Data(self.utf8).base64EncodedString()
	}
	
	/// Converts an HTML string to an attributed string.
	///
	/// - Returns: the attributed string to use/display
	func convertHtmlToAttributeString() -> NSAttributedString {
		guard let data = data(using: .utf8) else { return NSAttributedString() }
		do {
			return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
		} catch {
			return NSAttributedString()
		}
	}
	
	/// Left pad a string to a desired length with the selected character.
	///
	/// - Parameters:
	///   - toLength: the length the resulting string should be
	///   - character: the character to pad with
	/// - Returns: a new string that is padded
	func leftPadding(toLength: Int, withPad character: Character) -> String {
		let stringLength = self.count
		if stringLength < toLength {
			return String(repeatElement(character, count: toLength - stringLength)) + self
		} else {
			return String(self.suffix(toLength))
		}
	}
}

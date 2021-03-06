//
//  ColorExtension.swift
//  GiftManager
//
//  Created by David Johnson on 4/15/18.
//  Copyright © 2018 David Johnson. All rights reserved.
//

import Foundation
import Cocoa


public extension NSColor {
	
	/// Gets the hex value, as a string from an NSColor object.
	///
	/// - Returns: the hex value of a color, as a string
	func toHex() -> String? {
		
			guard let rgbColor = usingColorSpace(NSColorSpace.genericRGB) else {
				return "FFFFFF"
			}
			let red = Int(round(rgbColor.redComponent * 0xFF))
			let green = Int(round(rgbColor.greenComponent * 0xFF))
			let blue = Int(round(rgbColor.blueComponent * 0xFF))
			let hexString = NSString(format: "#%02X%02X%02X", red, green, blue)
			return hexString as String
	}
	
}

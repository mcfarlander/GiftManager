//
//  ColorExtension.swift
//  GiftManager
//
//  Created by Dave on 4/15/18.
//  Copyright © 2018 org.djohnson. All rights reserved.
//

import Foundation
import Cocoa


public extension NSColor {
	
	func toHex() -> String? {
		
			guard let rgbColor = usingColorSpaceName(NSColorSpaceName.calibratedRGB) else {
				return "FFFFFF"
			}
			let red = Int(round(rgbColor.redComponent * 0xFF))
			let green = Int(round(rgbColor.greenComponent * 0xFF))
			let blue = Int(round(rgbColor.blueComponent * 0xFF))
			let hexString = NSString(format: "#%02X%02X%02X", red, green, blue)
			return hexString as String
	}
	
}

//
//  ColorExtension.swift
//  GiftManager
//
//  Created by Dave on 4/15/18.
//  Copyright © 2018 org.djohnson. All rights reserved.
//

import Foundation

extension CGColor
{
	func toHex(alpha: Bool = false) -> String?
	{
		guard let components = self.components, components.count >= 3 else {
			return nil
		}
		
		let r = Float(components[0])
		let g = Float(components[1])
		let b = Float(components[2])
		var a = Float(1.0)
		
		if components.count >= 4 {
			a = Float(components[3])
		}
		
		if alpha {
			return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
		} else {
			return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
		}
	}
}

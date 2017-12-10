//
//  StringExtension.swift
//  GiftManager
//
//  Created by David Johnson on 12/9/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation

extension String
{
	/** Trim front and back whitespace. */
	func trim() -> String
	{
		return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
	}
}

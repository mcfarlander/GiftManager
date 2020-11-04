//
//  HouseUtils.swift
//  GiftManager
//
//  Created by David Johnson on 11/3/20.
//  Copyright © 2020 org.djohnson. All rights reserved.
//

import Foundation


/// Various utility methods to assist with house and person data.
class HouseUtils {
	
	
	/// Takes the house id and person id sequence and creates a slightly hidden value.
	/// - Parameters:
	///   - houseId: the house id
	///   - personId: the person id
	/// - Returns: the reformatted string
	static func formatHousePersonIdNNHH(houseId: String, personId:String) -> String {
		
		let paddedHouseId = houseId.leftPadding(toLength: 2, withPad: "7")
		let paddedPersonId = personId.leftPadding(toLength: 2, withPad: "8")
		
		return paddedPersonId + paddedHouseId
		
	}
	
}

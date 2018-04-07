//
//  SheetProtocol.swift
//  GiftManager
//
//  Created by David Johnson on 12/9/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Foundation


/// Protocol for when a data object has been updated.
protocol SheetViewControllerDelegate
{
	
	/// Call for when the data object has been updated.
	func handleUpdate()
}


/// Protocol for when a house or person is updated.
protocol HousePersonViewControllerDelegate
{
	
	/// Callback for when a house has been updated.
	func handleUpdateHouse()
	
	
	/// Callback for when a person has been updated.
	func handleUpdatePerson()
}

//
//  SheetProtocol.swift
//  GiftManager
//
//  Created by David Johnson on 12/9/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation


/// Protocol for when a data object has been updated.
protocol SheetViewControllerDelegate {

	/// Call for when the data object has been updated.
	///
	/// - Parameter isCanceled: flag if the operation was canceled
	func handleUpdate(isCanceled:Bool)
}

/// Protocol for when a house or person is updated.
protocol HousePersonViewControllerDelegate {
	
	/// Callback for when a house has been updated.
	///
	/// - Parameter isCanceled: flag if the operation was canceled
	func handleUpdateHouse(isCanceled:Bool)
	
	/// Callback for when a person has been updated.
	///
	/// - Parameter isCanceled: flag if the operation was canceled
	func handleUpdatePerson(isCanceled:Bool)
}


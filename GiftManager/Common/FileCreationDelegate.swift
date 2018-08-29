//
//  FileCreationDelegate.swift
//  GiftManager
//
//  Created by David Johnson on 6/10/18.
//  Copyright © 2018 David Johnson. All rights reserved.
//

import Foundation

/// Protocol to define a callback for when the file was created and if there was a problem.
protocol FileCreationDelegate {
	
	/// Callback to indicate the file was created.
	///
	/// - Parameters:
	///   - success: flag if file was created ok
	///   - filePath: the path to where the file is located
	///   - errorMessage: if there was a problem, indicate it
	func handleWroteFile(success:Bool, filePath:String, errorMessage:String)
}

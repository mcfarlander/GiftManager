//
//  Enums.swift
//  GiftManager
//
//  Created by David Johnson on 2/5/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation

/// An enumeration of data operations
///
/// - Add: add a data element
/// - Update: update a data element
/// - Delete: delete a data slement
enum DataOperation:Int
{
	/// Add a data element
    case Add
	/// Update a data element
    case Update
	/// Delete a data slement
    case Delete
}

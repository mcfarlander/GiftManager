//
//  Route+CoreDataClass.swift
//  GiftManager
//
//  Created by David Johnson on 9/4/17.
//  Copyright © 2017 David Johnson. All rights reserved.
//

import Foundation
import CoreData


public class Route: NSManagedObject {
	
	/// Get the route number padded left. Example "01", "02", etc.
	var getFormatedRoute: String {
		get {
			return self.routenumber!.leftPadding(toLength: 2, withPad: "0")
		}
	}

}

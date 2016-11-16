//
//  Context.swift
//  GiftManager
//
//  Created by David Johnson on 11/15/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Foundation
import CoreData

/**
 AppContext holds a static reference to the mananaged contex.
 */
class AppContext
{
    /**
     The app's managed context.
     */
    static var managedObjectContext: NSManagedObjectContext? = nil
}



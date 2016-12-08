//
//  OrganizationViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/5/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa

class OrganizationViewController: NSViewController
{
    var managedContext = (NSApplication.shared().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
    }

}

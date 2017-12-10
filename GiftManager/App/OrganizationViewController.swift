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
	var managedContext = (NSApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var btnAddOrg: NSButton!
    @IBOutlet weak var btnUpdateOrg: NSButton!
    @IBOutlet weak var btnDeleteOrg: NSButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
        NSLog("Organizations view did load")
    }

    @IBAction func btnAddOrg_Action(_ sender: NSButton)
    {
        NSLog("add org action")
        
    }

    @IBAction func btnUpdateOrg_Action(_ sender: NSButton)
    {
        NSLog("update org action")
        
    }
    
    @IBAction func btnDeleteOrg_Action(_ sender: NSButton)
    {
        NSLog("delete org action")
        
    }
    
    
}

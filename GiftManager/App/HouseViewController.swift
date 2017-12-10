//
//  HouseViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/10/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa

class HouseViewController: NSViewController
{
	var managedContext = (NSApplication.shared.delegate as! AppDelegate).managedObjectContext

    @IBOutlet weak var btnAddHouse: NSButton!
    @IBOutlet weak var btnUpdateHouse: NSButton!
    @IBOutlet weak var btnDeleteHouse: NSButton!
    @IBOutlet weak var btnAddPerson: NSButton!
    @IBOutlet weak var btnUpdatePerson: NSButton!
    @IBOutlet weak var btnDeletePerson: NSButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
        NSLog("Houses view did load")
    }
    
    @IBAction func btnAddHouse_Action(_ sender: NSButton)
    {
        NSLog("add house action")
    }
    
    @IBAction func btnUpdateHouse_Action(_ sender: NSButton)
    {
        NSLog("update house action")
        
    }

    @IBAction func btnDeleteHouse_Action(_ sender: NSButton)
    {
        NSLog("delete house action")
        
    }
    
    @IBAction func btnAddPerson_Action(_ sender: NSButton)
    {
        NSLog("add person action")
        
    }
    
    @IBAction func btnUpdatePerson_Action(_ sender: NSButton)
    {
        NSLog("update person action")
        
    }
    
    @IBAction func btnDeletePerson_Action(_ sender: NSButton)
    {
        NSLog("delete person action")
        
    }
    
}

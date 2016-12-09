//
//  MenuViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/9/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa

class MenuViewController: NSViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showOrganizations"
        {
            if let destination = segue.destinationController as? OrganizationViewController
            {
                destination.loadView()
            }
        }

    }
    
    @IBAction func btnHouses_Action(_ sender: NSButton)
    {
        NSLog("Show Houses")
        
    }
    
    @IBAction func btnOrganizations_Action(_ sender: NSButton)
    {
        NSLog("Show Organizations")
        self.performSegue(withIdentifier: "showOrganizations", sender: self)

    }
    
    @IBAction func btnRoutes_Action(_ sender: NSButton)
    {
        NSLog("Show Routes")
        self.performSegue(withIdentifier: "showRoutes", sender: self)
        
    }
    
    
    
}

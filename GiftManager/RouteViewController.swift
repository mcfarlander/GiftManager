//
//  RouteViewController.swift
//  GiftManager
//
//  Created by David Johnson on 12/5/16.
//  Copyright © 2016 org.djohnson. All rights reserved.
//

import Cocoa

class RouteViewController: NSViewController
{
    var managedContext = (NSApplication.shared().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func btnClose_Action(_ sender: NSButton)
    {
        if managedContext.hasChanges
        {
            do
            {
                try managedContext.save()
            }
            catch
            {
                let nserror = error as NSError
                NSApplication.shared().presentError(nserror)
            }
        }
        
    }
    
    
}

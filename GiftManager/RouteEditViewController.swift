//
//  RouteEditViewController.swift
//  GiftManager
//
//  Created by David Johnson on 2/5/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Cocoa

class RouteEditViewController: NSViewController
{
    @IBOutlet weak var txtRouteNumber: NSTextField!
    @IBOutlet weak var txtStreetName: NSTextField!
    
    @IBOutlet weak var btnOk: NSButton!
    @IBOutlet weak var btnCancel: NSButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func btnOk_Action(_ sender: NSButton)
    {
    }
    
    @IBAction func btnCancel_Action(_ sender: NSButton)
    {
    }
    
    
    
}

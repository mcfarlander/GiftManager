//
//  RouteEditViewController.swift
//  GiftManager
//
//  Created by David Johnson on 2/5/17.
//  Copyright © 2017 org.djohnson. All rights reserved.
//

import Cocoa

class RouteEditViewController: NSWindowController
{
    
    var mainW: NSWindow = NSWindow()
    
    @IBOutlet weak var txtRouteNumber: NSTextField!
    @IBOutlet weak var txtStreetName: NSTextField!
    
    @IBOutlet weak var btnOk: NSButton!
    @IBOutlet weak var btnCancel: NSButton!
    
    var okCancel = false
    
    var route:Route = Route()
    var operation:DataOperation = DataOperation.Delete
    
    
    override init(window: NSWindow!)
    {
        super.init(window: window)
    }
    
    required init?(coder: (NSCoder!))
    {
        super.init(coder: coder);
    }
    
    override func windowDidLoad()
    {
        super.windowDidLoad()
        
        txtRouteNumber.stringValue = route.routenumber!
        txtStreetName.stringValue = route.street!
        
        switch operation
        {
        case DataOperation.Add:
            txtRouteNumber.isEnabled = true
            txtStreetName.isEnabled = true
        case DataOperation.Update:
            txtRouteNumber.isEnabled = true
            txtStreetName.isEnabled = true
        case DataOperation.Delete:
            txtRouteNumber.isEnabled = false
            txtStreetName.isEnabled = false
        }
    }


    @IBAction func btnOk_Action(_ sender: NSButton)
    {
        self.route.routenumber = txtRouteNumber.stringValue
        self.route.street = txtStreetName.stringValue
        self.okCancel = true
        endSheet()
        
    }
    
    @IBAction func btnCancel_Action(_ sender: NSButton)
    {
        okCancel = false
        endSheet()
        
    }
    
    //method called to display the modal window
    func beginSheet(mainWindow: NSWindow)
    {
        self.mainW = mainWindow
        mainWindow.beginSheet(self.window!, completionHandler: nil)
        
    }
    
    //method called to slide out the modal window
    func endSheet()
    {
        self.mainW.endSheet(self.window!)
        self.window!.orderOut(mainW)
    }
    
}

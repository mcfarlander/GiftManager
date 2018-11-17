//
//  MapViewController.swift
//  GiftManager
//
//  Created by Dave on 11/17/18.
//  Copyright © 2018 org.djohnson. All rights reserved.
//

import Cocoa
import CoreData
import MapKit

/// A view controller to show the houses on a map.
class MapViewController: NSViewController {

	@IBOutlet var mapView: MKMapView!
	@IBOutlet var btnOk: NSButton!
	
	fileprivate let houseDao = HouseDao()
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	@IBAction func btnOk_Action(_ sender: Any) {
		self.dismiss(self)
	}
	
}

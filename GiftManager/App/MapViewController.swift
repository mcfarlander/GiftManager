//
//  MapViewController.swift
//  GiftManager
//
//  Created by Dave on 11/17/18.
//  Copyright © 2018 org.djohnson. All rights reserved.
//

import Cocoa
import CoreData
import CoreLocation
import MapKit

/// A view controller to show the houses on a map.
class MapViewController: NSViewController, CLLocationManagerDelegate, MKMapViewDelegate {

	@IBOutlet var mapView: MKMapView!
	@IBOutlet var btnOk: NSButton!
	
	fileprivate let houseDao = HouseDao()
	
	private var locationManager = CLLocationManager()
	private let authorizationStatus = CLLocationManager.authorizationStatus()
	// the radius around the user's current location, assumption is made that
	// the user and the addresses are nearby
	private let regionRadius: Double = 3500
	
	override func viewDidLoad() {
		
        super.viewDidLoad()
		
		mapView.delegate = self
		locationManager.delegate = self
		locationManager.startUpdatingLocation()
		
		mapHouses()
    }
	
	@IBAction func btnOk_Action(_ sender: Any) {
		self.dismiss(self)
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		centerMapOnUserLocation()
	}
	
	func centerMapOnUserLocation() {
		guard let coordinate = locationManager.location?.coordinate else {return}
		let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: true)
		locationManager.stopUpdatingLocation()
	}
	
	/// Map the houses onto the MKMapView.
	private func mapHouses() {
		
		for house in self.houseDao.list()! {
			
			if let address = house.address {
				
				if address.count > 0 {
					// set the address prefix accordingly
					let addr = Constants.ADDRRESS_PREFIX  + address
				
					let geocoder = CLGeocoder() // create a new one for each search
					geocoder.geocodeAddressString(addr) { (placemarks, error) in
						
						if let error = error {
							NSLog("Unable to Forward Geocode Address (\(error))")
							
						} else if let placemarks = placemarks {
							if placemarks.count != 0 {
								let annotation = MKPlacemark(placemark: placemarks.first!)
								self.mapView.addAnnotation(annotation)
							}
						}
						
					}
					
				}
				
			}
			
		}
		
	}

}

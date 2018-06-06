//
//  MapController.swift
//  ping
//
//  Created by Farhan Saeed on 24/5/18.
//  Copyright © 2018 Farhan Saeed. All rights reserved.
//

import UIKit
import GoogleMaps

class MapController: UIViewController {
    
    let defaults = UserDefaults.standard
    var locValue: CLLocationCoordinate2D!
    
    private let locationManager = CLLocationManager()
    lazy var mapView = GMSMapView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view = getMapWithCurrentLocation()
    }
    
    @IBAction func copyAction(_ sender: UIBarButtonItem) {
        UIPasteboard.general.string = "\(locValue.latitude),\(locValue.longitude)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getMapWithCurrentLocation() -> UIView{
        //adding sydney as default location
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height), camera: camera)
        mapView.isMyLocationEnabled = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        locValue = (locationManager.location?.coordinate)!
        mapView.camera=GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 15.0)
        return mapView
    }
}

//
//  SearchController.swift
//  ping
//
//  Created by Farhan Saeed on 29/5/18.
//  Copyright © 2018 Farhan Saeed. All rights reserved.
//

import UIKit
import Foundation
import GoogleMaps
import GooglePlaces

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class SearchController: UIViewController {
    var mapView = GMSMapView()
    private let locationManager = CLLocationManager()
    let defaults = UserDefaults.standard
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        mapView = MapController().getMapWithCurrentLocation() as! GMSMapView
        view = mapView
        
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "find", style: .done, target: self, action: #selector(searchTapped))
    }
    @objc func searchTapped()
    {
        getPolylineRoute(destination:searchBar.text!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //search bar goes here
    func getPolylineRoute(destination:String)
    {
        let locValue = getCurrentLocation()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let origin = "\(locValue.latitude),\(locValue.longitude)"
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving")!
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else
            {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
                        
                        let routes = json["routes"] as? [Any]
                        for route in routes!
                        {
                            let routeOverviewPolyline:NSDictionary = (route as! NSDictionary).value(forKey: "overview_polyline") as! NSDictionary
                            let points = routeOverviewPolyline.object(forKey: "points")
                            let path = GMSPath.init(fromEncodedPath: points! as! String)
                            let polyline = GMSPolyline.init(path: path)
                            polyline.strokeWidth = 3
                            
                            polyline.map = self.mapView
                        }
                    }
                }
                catch
                {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    //current location goes here

}

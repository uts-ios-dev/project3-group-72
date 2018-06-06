//
//  ViewController.swift
//  ping
//
//  Created by Farhan Saeed on 24/5/18.
//  Copyright © 2018 Farhan Saeed. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAzFbOgk3wQM_pVMRApAEfOng4rF70e-e8")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//
//  ShopsViewController+MKMapViewDelegate.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension ShopsViewController: MKMapViewDelegate {

    //shopsMap
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        
        self.shopsMap.delegate = self

        let londonLocation = CLLocation(latitude: 51.5073509, longitude: -0.1277583)
        self.shopsMap.setCenter(londonLocation.coordinate, animated: true)
        
        
        
    }


}

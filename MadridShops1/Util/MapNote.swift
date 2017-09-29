//
//  MapNote.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Note: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

public func addLocation(latitude: String, longitude: String, map: MKMapView, title: String, subtitle: String, adjust: Double) {
    let location = CLLocation(latitude: Double(latitude)!, longitude: Double(longitude)!)
    map.setCenter(location.coordinate, animated: true)
    
    let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: adjust, longitudeDelta: adjust))
    let reg = map.regionThatFits(region)
    map.setRegion(reg, animated: true)

    let note = Note(coordinate: location.coordinate, title: title, subtitle: subtitle)
    map.addAnnotation(note)
}

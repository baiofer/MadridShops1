//
//  ActivityDetailViewController.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import MapKit

class ActivityDetailViewController: UIViewController {
    
    var activity: ActivityCD?

    @IBOutlet weak var activityDetailMap: MKMapView!
    @IBOutlet weak var activityDetailText: UITextView!
    @IBOutlet weak var activityDetailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.activity?.name
        self.activityDetailText.text = self.activity?.desc
        self.activity?.image?.loadImage(into: activityDetailImage)
        
        addLocation(latitude: (activity?.latitude)!, longitude: (activity?.longitude)!, map: activityDetailMap, title: (activity?.name)!, subtitle: (activity?.address)!, adjust: 0.005)
     
    }
}

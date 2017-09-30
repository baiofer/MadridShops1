//
//  ShopDetailViewController.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import MapKit

class ShopDetailViewController: UIViewController {

    var shop: ShopCD?
    
    @IBOutlet weak var shopDetailMap: MKMapView!
    @IBOutlet weak var shopDetailText: UITextView!
    @IBOutlet weak var shopDetailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.shop?.name
        let pre = NSLocale.preferredLanguages[0]
        if pre == "en" {
            self.shopDetailText.text = self.shop?.desc_en
        } else {
            self.shopDetailText.text = self.shop?.desc
        }
        self.shop?.image?.loadImage(into: shopDetailImage)
        
        addLocation(latitude: (shop?.latitude)!, longitude: (shop?.longitude)!, map: shopDetailMap, title: (shop?.name)!, subtitle: (shop?.address)!, adjust: 0.005)
    }

 

}

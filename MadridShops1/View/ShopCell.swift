//
//  ShopCell.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import MapKit

class ShopCell: UICollectionViewCell {
    
    var shop: ShopCD?
    
    @IBOutlet weak var shopCellImage: UIImageView!
    @IBOutlet weak var shopCellNameLabel: UILabel!
    @IBOutlet weak var shopCellOpeningLabel: UILabel!

    func refresh(shop: ShopCD) {
        self.shop = shop
        self.shopCellNameLabel.text = shop.name?.uppercased()
        self.shopCellOpeningLabel.text = shop.openingHours?.uppercased()
        self.shop?.logo?.loadImage(into: shopCellImage)
    }
}

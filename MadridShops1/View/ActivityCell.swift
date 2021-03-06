//
//  ActivityCell.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import MapKit

class ActivityCell: UICollectionViewCell {
    
    var activity: ActivityCD?
    
    @IBOutlet weak var activityCellImage: UIImageView!
    @IBOutlet weak var activityCellNameLabel: UILabel!
    @IBOutlet weak var activityCellOpeningLabel: UILabel!
    
    func refresh(activity: ActivityCD) {
        self.activity = activity
        self.activityCellNameLabel.text = activity.name?.uppercased()
        self.activityCellOpeningLabel.text = activity.openingHours?.uppercased()
        self.activity?.logo?.loadImage(into: activityCellImage)
        
    }
}

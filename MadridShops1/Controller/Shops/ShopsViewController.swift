//
//  ShopsViewController.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ShopsViewController: UIViewController, MKMapViewDelegate {
    
    var context: NSManagedObjectContext!
    var locationManager: CLLocationManager?

    @IBOutlet weak var shopsCollectionView: UICollectionView!
    @IBOutlet weak var shopsMap: MKMapView!
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<ShopCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ShopCD> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let fetchRequest: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.shopsCollectionView.delegate = self
        self.shopsCollectionView.dataSource = self
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        self.shopsMap.delegate = self as MKMapViewDelegate
        
        addLocations()
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let shop: ShopCD = self.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shop)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let vc = segue.destination as! ShopDetailViewController
            
            let shopCD: ShopCD = sender as! ShopCD
            vc.shop = shopCD
        }
    }
    
    func addLocations() {
        
        let londonLocation = CLLocation(latitude: 51.5073509, longitude: -0.1277583)
        self.shopsMap.setCenter(londonLocation.coordinate, animated: true)
        
        //let region = MKCoordinateRegion(center: londonLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        //let reg = self.mapView.regionThatFits(region)
        //self.mapView.setRegion(reg, animated: true)
        
        
        //let n=Note(coordinate: londonLocation.coordinate, title: "Hello", subtitle: "Hello sub")
        //self.mapView.addAnnotation(n)
    }
    
}













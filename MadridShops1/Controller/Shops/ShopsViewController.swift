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
    
    func getShop(name: String) -> ShopCD {
        let fetchRequest1: NSFetchRequest<ShopCD> = ShopCD.fetchRequest()
        fetchRequest1.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let fetchedResultsController1 = NSFetchedResultsController(fetchRequest: fetchRequest1, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController1.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        let consulta: [ShopCD] = fetchedResultsController1.fetchedObjects!
        let shop = consulta.filter { (shop) -> Bool in
            return shop.name == name
        }
        return shop[0]
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
        if (segue.identifier == "ShowShopDetailSegue") {
            let vc = segue.destination as! ShopDetailViewController
            let shopCD: ShopCD = sender as! ShopCD
            vc.shop = shopCD
        }
        if (segue.identifier == "ShowShopDetailSegueFromAnnotation") {
            let vc1 = segue.destination as! ShopDetailViewController
            let shopCD: ShopCD = sender as! ShopCD
            vc1.shop = shopCD
        }
    }
    
    func addLocations() {
        let madridLocation = CLLocation(latitude: 40.41889, longitude: -3.69194)
        self.shopsMap.setCenter(madridLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06))
        let reg = self.shopsMap.regionThatFits(region)
        self.shopsMap.setRegion(reg, animated: true)
        
        for i in 0 ..< self.fetchedResultsController.sections![0].numberOfObjects {
            let index = IndexPath(row: i, section: 0)
            let shop: ShopCD = fetchedResultsController.object(at: index)
            let location = CLLocation(latitude: Double(shop.latitude!)!, longitude: Double(shop.longitude!)!)
            let note = Note(coordinate: location.coordinate, title: shop.name!, subtitle: shop.address!)
            shopsMap.addAnnotation(note)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let shop = getShop(name: view.annotation?.title as! String)
        self.performSegue(withIdentifier: "ShowShopDetailSegueFromAnnotation", sender: shop)
    }
}













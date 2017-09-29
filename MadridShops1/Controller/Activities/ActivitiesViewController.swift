//
//  ActivitiesViewController.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ActivitiesViewController: UIViewController, MKMapViewDelegate {
    
    var context: NSManagedObjectContext!
    var locationManager: CLLocationManager?

    @IBOutlet weak var activitiesCollectionView: UICollectionView!
    @IBOutlet weak var activitiesMap: MKMapView!
    
    var _fetchedResultsController: NSFetchedResultsController<ActivityCD>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ActivityCD> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let fetchRequest: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ActivitiesCacheFile")
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

        self.activitiesCollectionView.delegate = self
        self.activitiesCollectionView.dataSource = self
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        self.activitiesMap.delegate = self as MKMapViewDelegate
        
        addLocations()
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activity: ActivityCD = self.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowActivityDetailSegue" {
            let vc = segue.destination as! ActivityDetailViewController
            let activityCD: ActivityCD = sender as! ActivityCD
            vc.activity = activityCD
        }
    }
    
    func addLocations() {
        
        let londonLocation = CLLocation(latitude: 51.5073509, longitude: -0.1277583)
        self.activitiesMap.setCenter(londonLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: londonLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let reg = self.activitiesMap.regionThatFits(region)
        self.activitiesMap.setRegion(reg, animated: true)
        
        
        let n=Note(coordinate: londonLocation.coordinate, title: "Hello", subtitle: "Hello sub")
        self.activitiesMap.addAnnotation(n)
    }

}

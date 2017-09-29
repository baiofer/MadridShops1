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
        self.locationManager?.startUpdatingLocation()
        
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
        if (segue.identifier == "ShowActivityDetailSegueFromAnnotation") {
            let vc1 = segue.destination as! ActivityDetailViewController
            let activityCD: ActivityCD = sender as! ActivityCD
            vc1.activity = activityCD
        }
    }
    
    func getActivity(name: String) -> ActivityCD {
        let fetchRequest1: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
        fetchRequest1.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let fetchedResultsController1 = NSFetchedResultsController(fetchRequest: fetchRequest1, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController1.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        let consulta: [ActivityCD] = fetchedResultsController1.fetchedObjects!
        let activity = consulta.filter { (activity) -> Bool in
            return activity.name == name
        }
        return activity[0]
    }

    func addLocations() {
        
        let madridLocation = CLLocation(latitude: 40.41889, longitude: -3.69194)
        self.activitiesMap.setCenter(madridLocation.coordinate, animated: true)
        
        let region = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        let reg = self.activitiesMap.regionThatFits(region)
        self.activitiesMap.setRegion(reg, animated: true)
        
        for i in 0 ..< self.fetchedResultsController.sections![0].numberOfObjects {
            let index = IndexPath(row: i, section: 0)
            let activity: ActivityCD = fetchedResultsController.object(at: index)
            let location = CLLocation(latitude: Double(activity.latitude!)!, longitude: Double(activity.longitude!)!)
            let note = Note(coordinate: location.coordinate, title: activity.name!, subtitle: activity.address!)
            activitiesMap.addAnnotation(note)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view)
        let activity = getActivity(name: view.annotation?.title as! String)
        self.performSegue(withIdentifier: "ShowActivityDetailSegueFromAnnotation", sender: activity)
    }
}

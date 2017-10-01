//
//  JasonParseTest.swift
//  MadridShops1Tests
//
//  Created by Fernando Jarilla on 1/10/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import XCTest
import CoreData
@testable import MadridShops1

class JasonParseTest: XCTestCase {
    
    var _fetchedResultsController: NSFetchedResultsController<ActivityCD>? = nil
    var fetchedResultsController: NSFetchedResultsController<ActivityCD> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        let context = setUpInMemoryManagedObjectContext()
        let fetchRequest: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: "ActivitiesCacheFile")
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
    
    
    
    func jsonToNSData(json: String) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func testParseShops() {
        let context = setUpInMemoryManagedObjectContext()
        var _fetchedResultsController: NSFetchedResultsController<ActivityCD>? = nil
        var fetchedResultsController: NSFetchedResultsController<ActivityCD> {
            if _fetchedResultsController != nil {
                return _fetchedResultsController!
            }
            let fetchRequest: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
            fetchRequest.fetchBatchSize = 20
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: "ActivitiesCacheFile")
            do {
                try _fetchedResultsController!.performFetch()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            return _fetchedResultsController!
        }
        //Convierto el json a Data y lo parseo
        if let path = Bundle.main.url(forResource: "activities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                parseActivities(data: data, context: context)
            } catch {
                print("No hay fichero")
            }
            //Cojo el array de Activities del context
            let fetchRequest1: NSFetchRequest<ActivityCD> = ActivityCD.fetchRequest()
            fetchRequest1.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            let fetchedResultsController1 = NSFetchedResultsController(fetchRequest: fetchRequest1, managedObjectContext: context,  sectionNameKeyPath: nil, cacheName: nil)
            do {
                try fetchedResultsController1.performFetch()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
            let consulta: [ActivityCD] = fetchedResultsController1.fetchedObjects!
            //Cojo la primera activity (y única del fichero)
            let activity: ActivityCD = consulta[0]
            XCTAssertEqual(activity.name, "Tour del Bernabéu")
        }
    }
}

//
//  ActivityTests.swift
//  MadridShops1Tests
//
//  Created by Fernando Jarilla on 1/10/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import XCTest
import CoreData
@testable import MadridShops1

class ActivityTests: XCTestCase {
    
    var activities = Activities()
    
    override func setUp() {
        super.setUp()
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
    
    func testShopsExistance() {
        XCTAssertNotNil(activities)
    }

    func testActivityCount() {
        let context2 = setUpInMemoryManagedObjectContext()
        let activity1 = ActivityCD(context: context2)
        activity1.name = "Super BM"
        activities.add(activity: activity1)
        XCTAssertEqual(activities.count(), 1)
    }
    
    func testActivityAdd() {
        let context2 = setUpInMemoryManagedObjectContext()
        let activity1 = ActivityCD(context: context2)
        activity1.name = "Super BM"
        activities.add(activity: activity1)
        let activity2 = ActivityCD(context: context2)
        activity2.name = "El Corte Inglés"
        activities.add(activity: activity2)
        XCTAssertEqual(activities.count(), 2)
    }
    
    func testActivityGet() {
        let context2 = setUpInMemoryManagedObjectContext()
        let activity1 = ActivityCD(context: context2)
        activity1.name = "Super BM"
        activities.add(activity: activity1)
        let activityName = activities.get(index: 0).name
        XCTAssertEqual(activityName, "Super BM")
    }
}

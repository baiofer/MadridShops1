//
//  ShopsTests.swift
//  MadridShops1Tests
//
//  Created by Fernando Jarilla on 1/10/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import XCTest
import CoreData
@testable import MadridShops1

class ShopsTests: XCTestCase {

    var shops = Shops()

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
        XCTAssertNotNil(shops)
    }
    
    func testShopsCount() {
        let context1 = setUpInMemoryManagedObjectContext()
        //let entity = NSEntityDescription.insertNewObject(forEntityName: "EntityName", into: context1)
        
        let shop5 = ShopCD(context: context1)
        shop5.name = "Super BM"
        shops.add(shop: shop5)
        XCTAssertEqual(shops.count(), 1)
    }
    
    func testShopsAdd() {
        let context1 = setUpInMemoryManagedObjectContext()
        let shop5 = ShopCD(context: context1)
        shop5.name = "Super BM"
        shops.add(shop: shop5)
        let shop6 = ShopCD(context: context1)
        shop6.name = "El Corte Inglés"
        shops.add(shop: shop6)
        XCTAssertEqual(shops.count(), 2)
    }
    
    func testShopsGet() {
        let context1 = setUpInMemoryManagedObjectContext()
        let shop5 = ShopCD(context: context1)
        shop5.name = "Super BM"
        shops.add(shop: shop5)
        let shopName = shops.get(index: 0).name
        XCTAssertEqual(shopName, "Super BM")
    }
}

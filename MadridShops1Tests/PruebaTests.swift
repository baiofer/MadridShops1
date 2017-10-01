//
//  PruebaTests.swift
//  MadridShops1Tests
//
//  Created by Fernando Jarilla on 1/10/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import XCTest
import CoreData
@testable import MadridShops1

class PruebaTests: XCTestCase {
    
    var cds = CoreDataStack()
    var context: NSManagedObjectContext?
    var preparedForTest: Bool = false
    var shops: [ShopCD]?
    
    override func setUp() {
        super.setUp()
        
        self.context = cds.createContainer(dbName: "TestsMadridShops").viewContext
        
        ExecuteOneInteractorImplementation().execute {
            let queue = OperationQueue()
            queue.addOperation {
                //Testear si hay conexión
                var network = isConnectedToNetwork()
                while !network {
                    network = isConnectedToNetwork()
                }
                OperationQueue.main.addOperation {
                    self.initializeData()
                }
            }
        }
    }
    
    func initializeData() {
        let urlShops = "https://madrid-shops.com/json_new/getShops.php"
        let downloadShops: DownloadAllInteractor = DownloadAllInteractorNSURLSessionImplementation()
        downloadShops.execute(context: context!, urlString: urlShops, type: .ShopCD) {
            
            
            print("Todo cargado. Listo para el test")
            self.preparedForTest = true
        }
    }
    
    func execute(context: NSManagedObjectContext, urlString: String, type: DataType, onSuccess: @escaping () -> Void, onError: ErrorClosure) {
        let session = URLSession.shared
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    if error == nil {
                        //OK
                        if type == .ShopCD {
                            _ = parseShops(data: data!, context: context)
                        } else {
                            _ = parseActivities(data: data!, context: context)
                        }
                        onSuccess()
                    } else {
                        //Error
                        if let myError = onError {
                            myError(error!)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func testShopsExistance() {
        while !preparedForTest {}
        
        
    }
    
    
    func testShopsCount() {
        
    }
    
    func testShopsAdd() {
        
    }
    
    func testShopsGet() {
        
    }
    
    
    

    
}

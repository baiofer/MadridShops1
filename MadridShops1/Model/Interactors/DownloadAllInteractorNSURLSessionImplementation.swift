//
//  DownloadAllInteractorNSURLSessionImplementation.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import Foundation
import CoreData

class DownloadAllInteractorNSURLSessionImplementation: DownloadAllInteractor {
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
    
    func execute(context: NSManagedObjectContext, urlString: String, type: DataType, onSuccess: @escaping () -> Void) {
        execute(context: context, urlString: urlString, type: type, onSuccess: onSuccess, onError: nil)
    }
}

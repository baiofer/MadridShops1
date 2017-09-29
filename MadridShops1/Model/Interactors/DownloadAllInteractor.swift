//
//  DownloadAllInteractor.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import Foundation
import CoreData

protocol DownloadAllInteractor {
    func execute(context: NSManagedObjectContext, urlString: String, type: DataType, onSuccess: @escaping () -> Void, onError: ErrorClosure)
    func execute(context: NSManagedObjectContext, urlString: String, type: DataType, onSuccess: @escaping () -> Void)
}

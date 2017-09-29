//
//  ExecuteOneInteractorImplementation.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import Foundation

class ExecuteOneInteractorImplementation: ExecuteOneInteractor {
    func execute(closure: () -> Void) {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "once") {
            //alredy save
        } else {  //first time
            closure()
        }
    }
}

//
//  SetExecutedOneInteractorImplementation.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import Foundation

class SetExecutedOnceInteractorImplementation: SetExecutedOnceInteractor {
    func execute() {
        let defaults = UserDefaults.standard
        defaults.set("SAVED", forKey: "once")
        defaults.synchronize()
    }
}

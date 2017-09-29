//
//  Activities.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import Foundation

protocol ActivitiesProtocol {
    func count() -> Int
    func add(activity: ActivityCD)
    func get(index: Int) -> ActivityCD
}

public class Activities: ActivitiesProtocol {
    
    private var activitiesList: [ActivityCD]?
    
    public init() {
        self.activitiesList = []
    }
    
    public func count() -> Int {
        return (activitiesList?.count)!
    }
    
    public func add(activity: ActivityCD) {
        activitiesList?.append(activity)
    }
    
    public func get(index: Int) -> ActivityCD {
        return (activitiesList?[index])!
    }
    
    
}

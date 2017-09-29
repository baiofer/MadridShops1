//
//  Shops.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import Foundation

protocol ShopsProtocol {
    func count() -> Int
    func add(shop: ShopCD)
    func get(index: Int) -> ShopCD
}

public class Shops: ShopsProtocol {
    
    private var shopsList: [ShopCD]?
    
    public init() {
        self.shopsList = []
    }
    
    public func count() -> Int {
        return (shopsList?.count)!
    }
    
    public func add(shop: ShopCD) {
        shopsList?.append(shop)
    }
    
    public func get(index: Int) -> ShopCD {
        return (shopsList?[index])!
    }
    
    
}

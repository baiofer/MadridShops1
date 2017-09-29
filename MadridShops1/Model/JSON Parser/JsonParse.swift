//
//  JsonParse.swift
//  MadridShops1
//
//  Created by Fernando Jarilla on 28/9/17.
//  Copyright © 2017 Jarzasa. All rights reserved.
//

import Foundation
import CoreData

func parseShops(data: Data, context: NSManagedObjectContext ) -> Void {
    
    let shops = Shops()
    do{
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        for shopJson in result {
            let shop = ShopCD(context: context)
            shop.name = shopJson["name"] as? String
            shop.address = shopJson["address"] as? String
            shop.desc = shopJson["description_es"] as? String
            shop.image = shopJson["img"] as? String
            shop.latitude = shopJson["gps_lat"] as? String
            shop.logo = shopJson["logo_img"] as? String
            shop.longitude = shopJson["gps_lon"] as? String
            shop.longitude = shopJson["gps_lon"] as? String
            shop.openingHours = (shopJson["opening_hours_es"] as! String)
            
            shops.add(shop: shop)
            saveContext(context: context)
        }
    } catch {
        print("Error parsing JSON")
    }
}

func parseActivities(data: Data, context: NSManagedObjectContext) -> Void {
    let activities = Activities()
    do{
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        for activityJson in result {
            let activity = ActivityCD(context: context)
            activity.name = activityJson["name"]! as? String
            activity.address = activityJson["address"] as? String
            activity.desc = activityJson["description_es"] as? String
            activity.image = activityJson["img"] as? String
            activity.latitude = activityJson["gps_lat"] as? String
            activity.logo = activityJson["logo_img"] as? String
            activity.longitude = activityJson["gps_lon"] as? String
            activity.openingHours = activityJson["opening_hours_es"] as? String
            
            activities.add(activity: activity)
            saveContext(context: context)
        }
    } catch {
        print("Error parsing JSON")
    }
}

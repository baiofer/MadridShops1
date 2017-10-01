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
            guard let sh1 = shopJson["address"] else { return }
            shop.address = sh1 as? String
            guard let sh2 = shopJson["description_es"] else { return }
            shop.desc = sh2 as? String
            guard let sh3 = shopJson["img"] else { return }
            shop.image = sh3 as? String
            guard let sh4 = shopJson["gps_lat"] else { return }
            var long1 = (sh4 as? String)?.trimmingCharacters(in: NSCharacterSet.whitespaces)
            if let i = long1?.characters.index(of: ",") {
                long1?.remove(at: i)
            }
            shop.latitude = long1
            guard let sh5 = shopJson["logo_img"] else { return }
            shop.logo = sh5 as? String
            guard let sh6 = shopJson["gps_lon"] else { return }
            var long2 = (sh6 as? String)?.trimmingCharacters(in: NSCharacterSet.whitespaces)
            if let i = long2?.characters.index(of: ",") {
                long2?.remove(at: i)
            }
            shop.longitude = long2
            guard let sh7 = shopJson["opening_hours_es"] else { return }
            shop.openingHours = sh7 as? String
            guard let sh8 = shopJson["description_en"] else { return }
            shop.desc_en = sh8 as? String
            
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
            guard let ac = activityJson["address"] else { return }
            activity.address = ac as? String
            guard let ac1 = activityJson["description_es"] else { return }
            activity.desc = ac1 as? String
            guard let ac2 = activityJson["img"] else { return }
            activity.image = ac2 as? String
            guard let ac3 = activityJson["gps_lat"] else { return }
            var long1 = (ac3 as? String)?.trimmingCharacters(in: NSCharacterSet.whitespaces)
            if let i = long1?.characters.index(of: ",") {
                long1?.remove(at: i)
            }
            activity.latitude = long1
            guard let ac4 = activityJson["logo_img"] else { return }
            activity.logo = ac4 as? String
            guard let ac5 = activityJson["gps_lon"] else { return }
            var long2 = (ac5 as? String)?.trimmingCharacters(in: NSCharacterSet.whitespaces)
            if let i = long2?.characters.index(of: ",") {
                long2?.remove(at: i)
            }
            activity.longitude = long2
            guard let ac6 = activityJson["opening_hours_es"] else { return }
            activity.openingHours = ac6 as? String
            guard let ac7 = activityJson["description_en"] else { return }
            activity.desc_en = ac7 as? String
            
            activities.add(activity: activity)
            saveContext(context: context)
        }
    } catch {
        print("Error parsing JSON")
    }
}

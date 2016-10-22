//
//  MapViewModel.swift
//  iCHEFMap
//
//  Created by Mission on 2016/10/21.
//  Copyright © 2016年 ichef. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class MapViewModel: NSObject {
    
    //MARK: - Life Cycle
    override init() {
        super.init()
        self.parseRestaurantData()
    }
    
    
    deinit {
        
    }
    
    
    func parseRestaurantData() {
        let fileName = Bundle.main.path(forResource: "ichef", ofType: "json")
        let realm = try! Realm()
        let data = try! Data(contentsOf: URL(fileURLWithPath: fileName!), options: Data.ReadingOptions.mappedIfSafe)
        let json = JSON(data: data)
        for (_,subJson):(String, JSON) in json {
            let restaurant = Restaurant()
            restaurant.id = subJson["id"].intValue
            restaurant.storeID = subJson["store_id"].stringValue
            restaurant.company = subJson["company"].stringValue
            restaurant.name = subJson["name"].stringValue
            restaurant.county = subJson["county"].stringValue
            restaurant.latitude = subJson["lat"].doubleValue
            restaurant.longitude = subJson["lng"].doubleValue
            restaurant.address = subJson["address"].stringValue
            restaurant.status = subJson["status"].stringValue
            try! realm.write {
                realm.add(restaurant, update: true)
            }
        }
    }
}

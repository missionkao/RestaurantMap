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
            restaurant.id = subJson["id"].int!
            print(restaurant.id)
            restaurant.storeID = subJson["store_id"].string!
            restaurant.company = subJson["company"].string!
            restaurant.name = subJson["name"].string!
            restaurant.county = subJson["county"].string!
            restaurant.latitude = subJson["lat"].double!
            restaurant.longitude = subJson["lng"].double!
            restaurant.address = subJson["address"].string!
            restaurant.status = subJson["status"].string!
            try! realm.write {
                realm.add(restaurant, update: true)
            }
        }
    }
}

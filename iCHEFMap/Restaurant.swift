//
//  Restaurant.swift
//  iCHEFMap
//
//  Created by Ｍission on 2016/10/22.
//  Copyright © 2016年 ichef. All rights reserved.
//

import RealmSwift

class Restaurant: Object {
    dynamic var id = 0
    dynamic var storeID = ""
    dynamic var company = ""
    dynamic var status = ""
    dynamic var address = ""
    dynamic var latitude = 0.0
    dynamic var longitude = 0.0
    dynamic var county = ""
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


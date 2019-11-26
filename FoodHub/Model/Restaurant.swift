//
//  Restaurant.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/10.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import Combine
import CoreLocation

class Restaurant: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var location: String
    var image: String
    var rating: String
    var phone: String
    var description: String
    
    init(name: String, type: String, location: String, image: String, rating: String, phone: String, description: String) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.rating = rating
        self.phone = phone
        self.description = description
    }
    
    convenience init() {
        self.init(name: "", type: "", location: "", image: "", rating: "", phone: "", description: "")
    }
}

var restaurantLocalData = [
    Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good restaurant"),
    Restaurant(name: "Lao Sichuan", type: "Chuan", location: "Zhuhai", image: "Wechat", rating: "Happy", phone: "6699", description: "A simple restaurant")
]
var restaurantCloudData: [Restaurant] = [
    Restaurant(name: "Lao Guangzhou", type: "Yue", location: "America", image: "Wechat", rating: "Happy", phone: "6599", description: "A good restaurant"),
    Restaurant(name: "Lao Chongqin", type: "Yu", location: "China", image: "restaurant", rating: "Happy", phone: "6699", description: "A simple restaurant")
]
var allRestaurant = restaurantLocalData + restaurantCloudData


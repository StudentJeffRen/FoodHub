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
    var realImage: Image?
    var rating: String
    var phone: String
    var description: String
    var ratingRow: [Int]
    var allowRating = true
    var isCloud = false
    var comments: [String] = []
    
    init(name: String, type: String, location: String, image: String, rating: String, phone: String, description: String, ratingRow: [Int]) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.rating = rating
        self.phone = phone
        self.description = description
        self.ratingRow = ratingRow
    }
    
    convenience init() {
        self.init(name: "", type: "", location: "", image: "", rating: "", phone: "Don't know", description: "Nothing to say", ratingRow: [0, 0, 0, 0, 0])
    }
}

var restaurantLocalData: [Restaurant] = [
//    Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "happy", phone: "6599", description: "A good restaurant", ratingRow: [0, 0, 0, 0, 0])
]

var restaurantCloudData: [Restaurant] = [
    Restaurant(name: "Food Hub", type: "Fast Food", location: "Macau University of Science and Technology", image: "foodpin-logo", rating: "angry", phone: "9966", description: "A terrible restaurant", ratingRow: [2, 0, 1, 99, 1024]),
    Restaurant(name: "Food Studio", type: "Chuan", location: "Macau University of Science and Technology", image: "restaurant", rating: "sad", phone: "251", description: "A cheap restaurant", ratingRow: [0, 0, 0, 0, 0]),
    Restaurant(name: "Lao Guangzhou", type: "Yue", location: "Taiwan", image: "homei", rating: "happy", phone: "6599", description: "A good restaurant", ratingRow: [0, 0, 0, 0, 0]),
    Restaurant(name: "Lao Chongqin", type: "Yu", location: "China", image: "cafeloisl", rating: "happy", phone: "6699", description: "A simple restaurant", ratingRow: [0, 0, 0, 0, 0])
    
]
var allRestaurant = restaurantLocalData + restaurantCloudData


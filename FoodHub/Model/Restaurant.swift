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
    var name = ""
    var type = ""
    var location = ""
    var imageName = "restaurant"
//    fileprivate var coordinates: Coordinates
    var rating = ""
    var phone = ""
    var isRating = false
    var description = ""
    
//    var locationCoordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: coordinates.latitude,
//            longitude: coordinates.longitude)
//    }
}

extension Restaurant {
    var image: Image {
        Image(imageName)
    }
}

//struct Coordinates: Hashable, Codable {
//    var latitude: Double
//    var longitude: Double
//}


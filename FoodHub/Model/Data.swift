//
//  Data.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/12.
//  Copyright © 2019 JeffRen. All rights reserved.
//  Abstract:
//  Helpers for loading images and data

import UIKit
import SwiftUI

var restaurantLocalData = [
    Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good restaurant"),
    Restaurant(name: "Lao Sichuan", type: "Chuan", location: "Zhuhai", image: "Wechat", rating: "Happy", phone: "6699", description: "A simple restaurant")
]
var restaurantCloudData: [Restaurant] = [
    Restaurant(name: "Lao Guangzhou", type: "Yue", location: "America", image: "Wechat", rating: "Happy", phone: "6599", description: "A good restaurant"),
    Restaurant(name: "Lao Chongqin", type: "Yu", location: "China", image: "restaurant", rating: "Happy", phone: "6699", description: "A simple restaurant")
]
var allRestaurant = restaurantLocalData + restaurantCloudData

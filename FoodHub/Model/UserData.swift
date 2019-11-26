//
//  UserData.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/13.
//  Copyright © 2019 JeffRen. All rights reserved.
//  这些变量改变时，会直接通知到 view

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
    init(from dataSouce: [Restaurant]) {
        self.restaurants = dataSouce
    }
}

final class UserAuth: ObservableObject {
    @Published var isLogin = false
}

final class SharedData: ObservableObject {
    @Published var sharedRestaurants: [Restaurant] = []
    
    init(from dataSource: [Restaurant]) {
        self.sharedRestaurants = dataSource
    }
}

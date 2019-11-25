//
//  RestaurantList.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/12.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RestaurantListCloud: View {
    @EnvironmentObject var cloudData: UserData
    
    var body: some View {
        
        NavigationView {
            List(cloudData.restaurants) { restaurant in
                RestaurantCloudRow(restaurant: restaurant)
            }
            
            .navigationBarTitle(Text("Cloud"))
        }
    }
}

struct RestaurantListCloud_Previews: PreviewProvider {
    static var previews: some View {
            RestaurantListCloud()
                .environmentObject(UserData(from: restaurantCloudData))
    }
}

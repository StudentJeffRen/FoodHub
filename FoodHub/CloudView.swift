//
//  RestaurantList.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/12.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RestaurantListCloud: View {
    @EnvironmentObject var cloudData: SharedData
    
    var body: some View {
        
        NavigationView {
            List(cloudData.sharedRestaurants) { restaurant in
                RestaurantCloudRow(restaurant: restaurant)
                    .environmentObject(self.cloudData)
            }
            
            .navigationBarTitle(Text("Cloud"))
        }
    }
}

struct RestaurantListCloud_Previews: PreviewProvider {
    static var previews: some View {
            RestaurantListCloud()
                .environmentObject(SharedData(from: restaurantCloudData))
    }
}

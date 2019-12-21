//
//  RestaurantList.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/12.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RestaurantListCloud: View {
    @EnvironmentObject var cloudData: CloudList
    @EnvironmentObject var localData: LocalList
    
    var body: some View {
        NavigationView {
            List(cloudData.restaurants) { restaurant in
                RestaurantCloudRow(restaurant: restaurant)
                    .environmentObject(self.cloudData)
                    .environmentObject(self.localData)
            }
            
            .navigationBarTitle(Text("Cloud"))
        }
        .onAppear {
            self.cloudData.startListener()
        }
        .onDisappear {
            self.cloudData.stopListener()
        }
    }
}

struct RestaurantListCloud_Previews: PreviewProvider {
    static var previews: some View {
            RestaurantListCloud()
                .environmentObject(SharedData(from: restaurantCloudData))
                .environmentObject(UserData(from: restaurantLocalData))
    }
}

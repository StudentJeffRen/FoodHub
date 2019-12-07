//
//  RestaurantList.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/12.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RestaurantListLocal: View {
    var locationManager = LocationManager()
    @EnvironmentObject var localData: UserData
    @State private var showNew = false
    
    var body: some View {
        
        NavigationView {
            RestaurantLocalList()
                .navigationBarTitle(Text("My Restaurants"))
                .navigationBarItems(trailing:
                    Button(action: { self.showNew = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundColor(.orange)
                    }.sheet(isPresented: $showNew) {
                        NewRestaurantView().environmentObject(self.localData)
                            .environmentObject(self.locationManager)
                    }
                )
            .environmentObject(self.locationManager)
        }
    }
}

struct RestaurantListLocal_Previews: PreviewProvider {
    static var previews: some View {
            RestaurantListLocal()
            .environmentObject(UserData(from: restaurantLocalData))
    }
}



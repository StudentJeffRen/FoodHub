//
//  RestaurantList.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/16.
//  Copyright © 2019 JeffRen. All rights reserved.
//  设置不同的 data，为本地，云端，搜索结果

import SwiftUI

struct RestaurantList: View {
    @EnvironmentObject var localData: UserData
    
    var body: some View {
        List {
            ForEach(localData.restaurants) { restaurant in
                NavigationLink(destination: RestaurantDetail(restaurant: restaurant)) {
                    RestaurantRow(restaurant: restaurant)
                }
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        localData.restaurants.remove(atOffsets: offsets)
    }
}

struct RestaurantRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        HStack {
            HStack(alignment: .top) {
                restaurant.image
                    .resizable()
                    .frame(width: 75, height: 75)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    Text(restaurant.name)
                        .font(.headline)
                    Text(restaurant.type)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                    Text(restaurant.location)
                        .font(.subheadline)
                        .foregroundColor(Color.gray)
                }
            }
            .scaledToFill()
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
            RestaurantList()
            .environmentObject(UserData(from: restaurantCloudData))
    }
}

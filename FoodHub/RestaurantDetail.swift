//
//  RestaurantDetailView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/10.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import UIKit

struct RestaurantDetail: View {
    @EnvironmentObject var localData: UserData
    @State private var showAlert = false
    
    var restaurant: Restaurant
    
    // 传过来的是 localData 中的哪一个
    var restaurantIndex: Int {
        localData.restaurants.firstIndex(where: {$0.id == restaurant.id})!
    }
    
    var body: some View {
        VStack {
//            MapView(coordinate: restaurant.locationCoordinate)
//                .frame(height: 300)
            
            CircleImage(image: restaurant.image)
                .offset(x: 0, y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(restaurant.name)
                        .font(.title)
                }
                
                HStack(alignment: .top) {
                    Text(restaurant.type)
                        .font(.subheadline)
                    Spacer()
                    HStack {
                        Image("phone")
                        Text(restaurant.phone)
                            .font(.subheadline)
                    }
                }
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle(Text(restaurant.name), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showAlert = true}) {
            Image(systemName: "square.and.arrow.up")
        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Reminder"), message: Text("Are you sure upload this restaurant to cloud?"), primaryButton: .default(Text("Yes"), action: {self.upload()}), secondaryButton: .cancel(Text("No")))
        }
    }
    
    func upload() {
        print("upload")
    }
}

struct RestaurantDetail_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetail(restaurant: restaurantData[0])
        .environmentObject(UserData(from: restaurantData))
        .environmentObject(UserData(from: restaurantCloudData))
    }
}

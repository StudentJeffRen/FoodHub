//
//  NewRestaurantMoreInfo.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/23.
//  Copyright © 2019 JeffRen. All rights reserved.
//  用多个 vstack 调整间距，图片大小

import SwiftUI

struct NewRestaurantMoreInfo: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var localData: UserData
    
    @Binding var name: String
    @Binding var type: String
    @Binding var address: String
    
    @Binding var rating:String
    @Binding var description: String
    
    @State var phone = ""
    
    var newRestaurant = Restaurant()
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Some additonal information(optional)")
                .font(.largeTitle)
                .lineLimit(2)
                        
            Text("Phone")
            TextField("Phone number", text: $phone)
                .padding()
            
            Text("Photo")
            Button(action: {self.addPicture()}) {
                Image(systemName: "plus.square")
            }
            
            
            Button(action: {
                self.saveToLocal()
            }) {
                Image("save")
            }
        }
        
    }
    
    func addPicture() {
        print("add picture")
    }
    
    func saveToLocal() {
        newRestaurant.name = name
        newRestaurant.type = type
        newRestaurant.location = address
        newRestaurant.rating = rating
        newRestaurant.description = description
        newRestaurant.phone = phone
        print("Name: \(newRestaurant.name)")
        print("Type: \(newRestaurant.type)")
        print("Address: \(newRestaurant.location)")
        print("Rating: \(newRestaurant.rating)")
        print("Description: \(newRestaurant.description)")
        print("phone: \(newRestaurant.phone)")
        localData.restaurants.append(newRestaurant)
        print("Current num: \(localData.restaurants.count)")
        self.presentationMode.wrappedValue.dismiss()
    }
}

//struct NewRestaurantMoreInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRestaurantMoreInfo()
//    }
//}

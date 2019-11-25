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
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var localData: UserData
    // @EnvironmentObject var cloudData: UserData
    @State private var showAlert = false
    
    var restaurant: Restaurant
    
    // 传过来的是 localData 中的哪一个
    var restaurantIndex: Int {
        localData.restaurants.firstIndex(where: {$0.id == restaurant.id})!
    }
    
    var body: some View {
        ScrollView {
            Image(restaurant.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading) {

                HStack {
                    VStack(alignment: .leading) {
                        Text(restaurant.name)
                            .font(.system(.largeTitle, design: .rounded))
                            
                        Text(restaurant.type)
                            .font(.system(.body, design: .rounded))
                            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                            .foregroundColor(.white)
                            .background(Color(.orange))
                            .cornerRadius(5)
                        
                    }
                    Spacer()
                    Image("happy")
                }
                
                HStack {
                    Image(systemName: "phone")
                    Text(restaurant.phone)
                }
                
                HStack {
                    Image(systemName: "location")
                    Text(restaurant.location)
                }
                
                VStack(alignment: .leading) {
                    Image(systemName: "text.badge.star")
                    Text(restaurant.description)
                }.padding(.bottom)
                
                Text("HOW TO GET HERE")
                    .bold()
                Divider()
                    .frame(height: 1)
                    .background(Color(.separator))
                
                // MapView
                
                standardButton(text: "Rating")
                
                
            }.padding(.horizontal)
            
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }, trailing:
                Button(action: {
                    self.showAlert = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Reminder"), message: Text("Are you sure upload this restaurant to cloud?"), primaryButton: .default(Text("Yes"), action: {self.upload()}), secondaryButton: .cancel(Text("No")))
        }
        }
        .edgesIgnoringSafeArea(.top)

    }
    
    func upload() {
        print("upload")
        // cloudData.restaurants.append(localData.restaurants[restaurantIndex])
    }
}

struct RestaurantDetail_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetail(restaurant: Restaurant(name: "Lao Changsha", type: "湘菜", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good place"))
        
    }
}

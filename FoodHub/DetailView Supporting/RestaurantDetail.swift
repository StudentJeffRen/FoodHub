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
    @EnvironmentObject var cloudData: SharedData
    @State private var showRating = false
    @State private var showEdit = false
    @State private var showAlert = false
    @State private var rating = ""
    
    var restaurant: Restaurant
    
    // 传过来的是 localData 中的哪一个
    var restaurantIndex: Int {
        localData.restaurants.firstIndex(where: {$0.id == restaurant.id})!
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(restaurant.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay(Image(restaurant.rating).resizable().frame(width: 60, height: 60).padding(), alignment: .bottomTrailing)
                    .overlay(Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                        }, alignment: .topLeading)
                    .overlay(Button(action: {
                            self.showEdit.toggle()
                        }) {
                            Image(systemName: "pencil.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            .padding()
                    }.sheet(isPresented: $showEdit) {
                        EditView(restaurantIndex: self.restaurantIndex).environmentObject(self.localData)
                    }, alignment: .topTrailing)
                
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
                        Button(action: {
                            self.showAlert.toggle()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "phone")
                        Text(restaurant.phone)
                    }
                    
                    HStack {
                        Image(systemName: "location")
                        Text(restaurant.location)
                    }
                    
                    HStack {
                        Image(systemName: "text.badge.star")
                        Text(restaurant.description)
                    }.padding(.bottom)
                    
                    Text("HOW TO GET HERE")
                        .bold()
                    Divider()
                        .frame(height: 1)
                        .background(Color(.separator))
                    
                    // MapViewsb
                    
                    Button(action: {
                        self.showRating.toggle()
                    }) {
                        standardButton(text: "Rating")
                    }.sheet(isPresented: $showRating) {
                        RatingView(restaurantIndex: self.restaurantIndex).environmentObject(self.localData)
                    }
                }.padding(.horizontal)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert) {
                Alert(title: Text("Reminder"), message: Text("Are you sure upload this restaurant to cloud?"), primaryButton: .default(Text("Yes"), action: {self.upload()}), secondaryButton: .cancel(Text("No")))
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    func upload() {
        print("upload")
        cloudData.sharedRestaurants.append(localData.restaurants[restaurantIndex])
    }
}

struct RestaurantDetail_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetail(restaurant: Restaurant(name: "Lao Changsha", type: "湘菜", location: "Macau", image: "restaurant", rating: "sad", phone: "6599", description: "A good place"))
        
    }
}

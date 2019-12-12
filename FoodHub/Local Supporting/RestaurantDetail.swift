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
    @EnvironmentObject var locationManager: LocationManager
    @State private var showRating = false
    @State private var showEdit = false
    @State private var showAlert = false
    @State private var rating = ""
    @State private var isCloud = false
    
    var restaurant: Restaurant
    
    // 传过来的是 localData 中的哪一个
    var restaurantIndex: Int {
        localData.restaurants.firstIndex(where: {$0.id == restaurant.id})!
    }
    
    var cloudIndex: Int {
        cloudData.sharedRestaurants.firstIndex(where: {$0.id == restaurant.id})!
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if(restaurant.realImage != nil) {
                    restaurant.realImage!
                        .resizable()
                        .frame(height: 300)
                        .overlay(Image(restaurant.rating).resizable().frame(width: 60, height: 60).padding(), alignment: .bottomTrailing)
                } else {
                    Image(restaurant.image)
                        .resizable()
                        .frame(height: 300)
                        .overlay(Image(restaurant.rating).resizable().frame(width: 60, height: 60).padding(), alignment: .bottomTrailing)
                }
                
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
                            Image(systemName: restaurant.isCloud ? "cloud" : "square.and.arrow.up")
                                .animation(.default)
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "phone")
                                Text(restaurant.phone)
                            }
                            
                            HStack {
                                Image(systemName: "location")
                                Text(restaurant.location)
                            }
                        }
                        Spacer()
                        
                        Button(action: {
                            self.showRating.toggle()
                        }) {
                            Text("Rating")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                        }.sheet(isPresented: $showRating) {
                            RatingView(restaurantIndex: self.restaurantIndex).environmentObject(self.localData)
                        }
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
                    
                    NavigationLink(destination: FullScreenMapView(location: restaurant.location)) {
                        MapView(location: restaurant.location)
                        .frame(height: 200)
                    }
                }.padding(.horizontal)
            }
        }
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
            }
            .sheet(isPresented: $showEdit) {
                EditView(restaurantIndex: self.restaurantIndex).environmentObject(self.localData).environmentObject(self.locationManager)
            }, alignment: .topTrailing)
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert) {
            switch isCloud {
            case true:
                return Alert(title: Text("Reminder"), message: Text("Cancel Share?"), primaryButton: .default(Text("Yes"), action: {self.cancelShare()}), secondaryButton: .cancel(Text("No")))
            case false:
                return Alert(title: Text("Reminder"), message: Text("Share?"), primaryButton: .default(Text("Yes"), action: {self.upload()}), secondaryButton: .cancel(Text("No")))
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.isCloud = self.restaurant.isCloud
        }
    }
    
    func upload() {
        print("upload")
        withAnimation {
            isCloud.toggle()
        }
        localData.restaurants[restaurantIndex].isCloud.toggle()
        cloudData.sharedRestaurants.append(localData.restaurants[restaurantIndex])
    }
    
    func cancelShare() {
        print("Remove from cloud")
        withAnimation {
            isCloud.toggle()
        }
        localData.restaurants[restaurantIndex].isCloud.toggle()
        cloudData.sharedRestaurants.remove(at: cloudIndex)
    }
}

struct RestaurantDetail_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetail(restaurant: Restaurant(name: "Lao Changsha", type: "湘菜", location: "Macau", image: "restaurant", rating: "sad", phone: "6599", description: "A good place", ratingRow: [0, 0, 0, 0, 0]))
        
    }
}

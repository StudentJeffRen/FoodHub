//
//  RestaurantDetailView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/10.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import UIKit
import Firebase

struct RestaurantDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var localData: LocalList
    @EnvironmentObject var cloudData: CloudList
    @EnvironmentObject var locationManager: LocationManager
    @State private var showRating = false
    @State private var showEdit = false
    @State private var showActionSheet = false
    @State private var rating = ""
    @State private var isCloud = false
    
    var restaurant: Restaurant
    @State var mutableRestaurant = Restaurant(id: UUID().uuidString,
                                                      name: "",
                                                      type: "",
                                                      location: "",
                                                      image: "discover",
                                                      rating: "",
                                                      phone: "",
                                                      description: "",
                                                      ratingRow: [0, 0, 0, 0, 0],
                                                      allowRating: [:],
                                                      isCloud: false,
                                                      comments: [],
                                                      isCollect: [:])
    
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
                            self.showActionSheet.toggle()
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
                            ratingButton()
                            .sheet(isPresented: $showRating) {
                                RatingView(restaurant: self.$mutableRestaurant).environmentObject(self.localData)
                            }
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
            backButton()
        }, alignment: .topLeading)
            
        .overlay(Button(action: {
            self.showEdit.toggle()
        }) {
            editButton()
            .sheet(isPresented: $showEdit) {
                EditView(restaurant: self.$mutableRestaurant).environmentObject(self.localData).environmentObject(self.locationManager)
            }
        }, alignment: .topTrailing)
            
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
            
        .actionSheet(isPresented: $showActionSheet) {
            switch isCloud {
            case true:
                return ActionSheet(title: Text("Cancel Share?"), buttons: [
                    .default(
                        Text("Yes"), action: self.cancelShare
                    ),
                    .destructive(Text("Cancel"))
                ])
                
            case false:
                return ActionSheet(title: Text("Share?"), buttons: [
                    .default(
                        Text("Yes"), action: self.upload
                    ),
                    .destructive(Text("Cancel"))
                ])
            }
        }
        
        
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            self.isCloud = self.restaurant.isCloud
            self.mutableRestaurant = self.restaurant
        }
    }
    
    func upload() {
        print("upload")
        withAnimation {
            isCloud.toggle()
        }
        
        switch self.restaurant.rating {
        case "love": mutableRestaurant.ratingRow[0] += 1
        case "happy": mutableRestaurant.ratingRow[1] += 1
        case "cool": mutableRestaurant.ratingRow[2] += 1
        case "sad": mutableRestaurant.ratingRow[3] += 1
        case "angry": mutableRestaurant.ratingRow[4] += 1
        default:
            break
        }
        
        mutableRestaurant.isCloud = true
        localData.updateRestaurnat(mutableRestaurant)
        cloudData.addRestaurnat(mutableRestaurant)
    }
    
    func cancelShare() {
        print("Remove from cloud")
        withAnimation {
            isCloud.toggle()
        }
        mutableRestaurant.isCloud = false
        localData.updateRestaurnat(mutableRestaurant)
        cloudData.removeRestaurant(mutableRestaurant)
    }
}

//struct RestaurantDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantDetail(restaurant: Restaurant(name: "Lao Changsha", type: "湘菜", location: "Macau", image: "restaurant", rating: "sad", phone: "6599", description: "A good place", ratingRow: [0, 0, 0, 0, 0]))
//        
//    }
//}

struct editButton: View {
    var body: some View {
        Image(systemName: "pencil.circle.fill")
            .font(.title)
            .foregroundColor(Color.secondary)
            .padding()
    }
}

struct backButton: View {
    var body: some View {
        Image(systemName: "chevron.left.circle.fill")
            .font(.title)
            .foregroundColor(Color.secondary)
            .padding()
    }
}

struct ratingButton: View {
    var body: some View {
        Text("Rating")
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
            .bold()
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
    }
}

//
//  RestaurantCloudRow.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/24.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import Firebase

struct RestaurantCloudRow: View {
    @EnvironmentObject var cloudData: SharedData
    @EnvironmentObject var localData: UserData
    var restaurant: Restaurant
    
    private let emojiChoices = ["love", "happy", "cool", "sad", "angry"]
    @State private var currentRating = [0, 0, 0, 0, 0]
    
    let user = Auth.auth().currentUser
    
    var userName: String {
        if let name = user?.displayName {
            return name
        } else {
            return "Unknown"
        }
    }
    
    @State var presentComments: [String] = []
    @State var newComment = ""

    @State private var showAlert = false
    @State private var showDetail = false
    @State private var isCollect = false
    
    var restaurantIndex: Int {
        cloudData.sharedRestaurants.firstIndex(where: {$0.id == restaurant.id})!
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if(restaurant.realImage != nil) {
                restaurant.realImage!
                    .resizable()
                    .aspectRatio(3/2, contentMode: .fit)
                    .cornerRadius(5)
            } else {
                Image(restaurant.image)
                .resizable()
                .aspectRatio(3/2, contentMode: .fit)
                .cornerRadius(5)
            }

            HStack {
                Text(restaurant.name)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .lineLimit(3)
                    .padding(.bottom, 0)
                
                Image(systemName: isCollect ? "star.fill" : "star")
                    .foregroundColor(isCollect ? .yellow : .black)
                    .onTapGesture {
                        if(self.isCollect == false) {
                            self.localData.restaurants.append(self.restaurant)
                        }
                        self.isCollect = true
                }
            }
            
            
            Text(restaurant.type)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
            
            // 点击 +1
            HStack(alignment: .bottom, spacing: 20) {
                ForEach(0...4, id: \.self) { emojiIndex in
                    HStack(spacing: 3) {
                        Image(self.emojiChoices[emojiIndex])
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text(String(self.currentRating[emojiIndex]))
                    }
                    .onTapGesture {
                        if(self.restaurant.allowRating) {
                            self.currentRating[emojiIndex] += 1
                            self.restaurant.ratingRow[emojiIndex] = self.currentRating[emojiIndex]
                            self.restaurant.allowRating = false
                        } else {
                            self.showAlert = true
                        }
                    }
                }
            }
            
            
            Text("More Detail")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .onTapGesture {
                    self.showDetail = true
            }
            
            HStack {
                Image(systemName: "text.bubble")
                TextField("Add a comment", text: $newComment)
                
                Image(systemName: "paperplane")
                    .foregroundColor(.black)
                    .onTapGesture {
                        if(self.newComment != "") {
                            self.presentComments.append("\(self.userName): \(self.newComment)")
                            self.restaurant.comments.append("\(self.userName): \(self.newComment)")
                            self.newComment = ""
                        }
                }
                .animation(.default)
                
            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(presentComments, id: \.self) { comment in
                    Text(comment)
                }
            }
        }
        .padding()
        .onAppear{
            self.currentRating = self.restaurant.ratingRow
            self.presentComments = self.restaurant.comments
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"), message: Text("You have already rated!"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showDetail) {
            CloudDetailView(restaurant: self.restaurant)
        }
    }
}

struct RestaurantCloudRow_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCloudRow(restaurant: Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good restaurant", ratingRow: [0, 0, 0, 0, 0]))
    }
}

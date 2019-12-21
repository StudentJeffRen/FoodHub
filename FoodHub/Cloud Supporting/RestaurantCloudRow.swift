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
    @EnvironmentObject var cloudData: CloudList
    @EnvironmentObject var localData: LocalList
    var restaurant: Restaurant
    private let emojiChoices = ["love", "happy", "cool", "sad", "angry"]
    @State private var currentRating = [0, 0, 0, 0, 0]
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

    let user = Auth.auth().currentUser

    var userName: String {
        if let name = user?.displayName {
            return name
        } else {
            return "Unknown"
        }
    }
    
    var userId: String {
        if let id = user?.uid {
            return id
        } else {
            return "Unknown"
        }
    }
    
    @State private var newComment = ""
    @State private var showAlert = false
    @State private var showDetail = false
    
    
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
                
                Image(systemName: (self.mutableRestaurant.isCollect[self.userId] == true) ? "star.fill" : "star")
                    .foregroundColor((self.mutableRestaurant.isCollect[self.userId] == true) ? .yellow : .black)
                    .onTapGesture {
                        if((self.mutableRestaurant.isCollect[self.userId] == true) == false) {
                            self.mutableRestaurant.isCollect[self.userId] = true
                            self.cloudData.updateRestaurnat(self.mutableRestaurant)
                            self.localData.addRestaurnat(self.mutableRestaurant)
                        }
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
                        Text(String(self.mutableRestaurant.ratingRow[emojiIndex]))
                    }
                    .onTapGesture {
                        if(self.mutableRestaurant.allowRating[self.userId] != false) {
                            self.mutableRestaurant.ratingRow[emojiIndex] += 1
                            self.mutableRestaurant.allowRating[self.userId] = false
                            self.cloudData.updateRestaurnat(self.mutableRestaurant)
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
                            self.mutableRestaurant.comments.append("\(self.userName): \(self.newComment)")
                            self.cloudData.updateRestaurnat(self.mutableRestaurant)
                            self.newComment = ""
                        }
                }
                .animation(.default)
                
            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(mutableRestaurant.comments, id: \.self) { comment in
                    Text(comment)
                }
            }
        }
        .padding()
        .onAppear{
            self.mutableRestaurant = self.restaurant
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"), message: Text("You have already rated!"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showDetail) {
            CloudDetailView(restaurant: self.restaurant)
        }
    }
}

//#if DEBUG
//struct RestaurantCloudRow_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantCloudRow(restaurant: Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good restaurant", ratingRow: [0, 0, 0, 0, 0]))
//    }
//}
//#endif

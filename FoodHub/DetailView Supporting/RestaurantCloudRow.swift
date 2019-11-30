//
//  RestaurantCloudRow.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/24.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RestaurantCloudRow: View {
    var restaurant: Restaurant
    private let emojiChoices = ["love", "happy", "cool", "sad", "angry"]
    @State private var currentRating = [0, 0, 0, 0, 0]
    @State private var showAlert = false
    @State private var showDetail = false
    let userName = "Jeff"
    @State var testComment = ["hello", "thank you", "do you like me?"]
    @State var newComment = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(restaurant.image)
                .resizable()
                .aspectRatio(3/2, contentMode: .fit)
                .cornerRadius(5)
            
            Text(restaurant.name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .lineLimit(3)
                .padding(.bottom, 0)
            
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
                Text("Send").onTapGesture {
                    self.testComment.append(self.newComment)
                    self.newComment = ""
                }
            }
            
            VStack(alignment: .leading, spacing: 5) {
                ForEach(testComment, id: \.self) { comment in
                    Text(self.userName + ": " + comment)
                }
            }
            
            
        }
        .padding()
        .onAppear{
            self.currentRating = self.restaurant.ratingRow
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"), message: Text("You have already rated!"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $showDetail) {
            CommentView(restaurant: self.restaurant)
        }
    }
}

struct RestaurantCloudRow_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCloudRow(restaurant: Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good restaurant"))
    }
}

//
//  CommentView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/30.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct CommentView: View {
    var restaurant: Restaurant
    let userName = "Jeff"
    @State var testComment = ["hello", "thank you", "do you like me?"]
    @State var newComment = ""
    
    var body: some View {
       
        VStack(alignment: .leading) {
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
            }
            
            MapView(location: restaurant.location)
                .frame(height: 200)
            
            HStack {
                Image(systemName: "text.bubble")
                TextField("Add a comment", text: $newComment)
                Text("Send").onTapGesture {
                    self.testComment.append(self.newComment)
                    self.newComment = ""
                }
            }.padding(.horizontal)
            
            List {
                ForEach(testComment, id: \.self) { comment in
                    Text(self.userName + ": " + comment)
                }
            }
            .frame(height: 300)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(restaurant: Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good restaurant"))
    }
}

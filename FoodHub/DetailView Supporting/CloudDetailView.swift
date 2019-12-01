//
//  CommentView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/30.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct CloudDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var restaurant: Restaurant

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.down.circle.fill")
                    .font(.title)
                    .foregroundColor(.gray)
                }
            }
            
            HStack {
                Image(systemName: "heart")
                Text(restaurant.name)
            }
            
            HStack {
                Image(systemName: "t.circle")
                Text(restaurant.type)
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
            }
            
            MapView(location: restaurant.location)
                
        }.padding()
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CloudDetailView(restaurant: Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good restaurant"))
    }
}

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
            
            HStack(spacing: 3) {
                ForEach(1...5, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Text(restaurant.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }.padding()
    }
}

struct RestaurantCloudRow_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCloudRow(restaurant: Restaurant(name: "Lao Changsha", type: "Xiang", location: "Macau", image: "restaurant", rating: "Happy", phone: "6599", description: "A good restaurant"))
    }
}

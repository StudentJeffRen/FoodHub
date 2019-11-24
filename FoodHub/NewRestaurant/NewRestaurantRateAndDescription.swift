//
//  NewRestaurantRateAndDescription.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/23.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct NewRestaurantRateAndDescription: View {
    @Binding var name: String
    @Binding var type: String
    @Binding var address: String
    
    @State var rating = ""
    @State var description = ""
    
    
    var body: some View {
        VStack {
            Text("Your feeling?")
            HStack(alignment: .bottom) {
                ratingButton(rating: $rating, ratingIndex: .constant(0))
                ratingButton(rating: $rating, ratingIndex: .constant(1))
                ratingButton(rating: $rating, ratingIndex: .constant(2))
            }
            HStack {
                ratingButton(rating: $rating, ratingIndex: .constant(3))
                ratingButton(rating: $rating, ratingIndex: .constant(4))
            }
            
            Text("Description")
            TextField("Description", text: $description)
                .padding()
                .border(Color.gray)
                .padding()
                
            NavigationLink(destination: NewRestaurantMoreInfo(name: $name, type: $type, address: $address, rating: $rating, description: $description)) {
                Text("Next")
            }
        }
        
    }
}

//struct NewRestaurantRateAndDescription_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRestaurantRateAndDescription()
//    }
//}

struct ratingButton: View {
    @Binding var rating: String
    @Binding var ratingIndex: Int
    let ratingOption = ["angry", "cool", "happy", "sad", "love"]
    
    var body: some View {
        Button(action: { self.rating = self.ratingOption[self.ratingIndex]}) {
            Image(ratingOption[ratingIndex])
        }
    }
}

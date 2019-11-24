//
//  NewRestaurant.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/22.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct NewRestaurant: View {
    @State var name: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Name")
                TextField("Enter name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                NavigationLink(destination: NewRestaurantType(name: $name)) {
                    Text("Next")
                }
            }
            .navigationBarItems(leading: Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "xmark")
            })
        }
    }
}

struct NewRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurant()
    }
}

//
//  NewRestaurantAddress.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/22.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct NewRestaurantAddress: View {
    @Binding var name: String
    @Binding var type: String
    
    @State var address = ""
    
    var body: some View {
        VStack {
            Text("Where?")
            
            HStack {
                Button(action: {self.getMyLocation()}) {
                    Image(systemName: "location.fill")
                }
                
                TextField("Type address", text: $address)
            }.padding()
            
            NavigationLink(destination: NewRestaurantRateAndDescription(name: $name, type: $type, address: $address)) {
                Text("Next")
            }
        }
    }
    
    func getMyLocation() {
        
    }
}

//struct NewRestaurantAddress_Previews: PreviewProvider {
//    static var previews: some View {
//        NewRestaurantAddress(name: .constant("hi"), type: .constant(""))
//    }
//}

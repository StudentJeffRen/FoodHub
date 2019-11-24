//
//  NewRestaurantType.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/22.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct NewRestaurantType: View {
    @Binding var name: String
    @State var type = ""
    
    var body: some View {
            VStack {
                Text("What type?")
                Text("Choosed type: \(type)")
                
                chooseTypeButton(type: $type, typeIndex: .constant(0))
                chooseTypeButton(type: $type, typeIndex: .constant(1))
                chooseTypeButton(type: $type, typeIndex: .constant(2))
                chooseTypeButton(type: $type, typeIndex: .constant(3))
                
                NavigationLink(destination: NewRestaurantAddress(name: $name, type: $type)) {
                    Text("Next")
                }
            }
    }
}

struct NewRestaurantType_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantType(name: .constant("New name"))
    }
}

struct chooseTypeButton: View {
    @Binding var type: String
    @Binding var typeIndex: Int
    let allTypes = ["Lao", "Xiang", "Chuan", "Fast food"]
    
    var body: some View {
        Button(action: { self.type = self.allTypes[self.typeIndex]}) {
            Text(allTypes[typeIndex])
        }
    }
}

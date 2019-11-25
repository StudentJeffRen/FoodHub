//
//  RestaurantList.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/12.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RestaurantListLocal: View {
    @EnvironmentObject var localData: UserData
    
    var body: some View {
        
        NavigationView {
            RestaurantLocalList()
                .navigationBarTitle(Text("My Restaurants"), displayMode: .large)
            //                    .navigationBarItems(trailing: addButton(destinationView: NewRestaurant().environmentObject(localData), isRegister: false))
        }
        
    }
    
}

struct RestaurantListLocal_Previews: PreviewProvider {
    static var previews: some View {
            RestaurantListLocal()
            .environmentObject(UserData(from: restaurantLocalData))
    }
}

struct addButton<Content: View>: View {
    @State private var showAddSheet = false
    var isRegister: Bool
    private var destinationView: Content
    
    init(destinationView: Content, isRegister: Bool) {
        self.destinationView = destinationView
        self.isRegister = isRegister
    }
    
    var body: some View {
        Button(action: {
            print("Button Pushed")
            self.showAddSheet.toggle()
            print(self.showAddSheet)
        }) {
            if isRegister {
                standardButton(text: "Register")
            } else {
                Image(systemName: "plus")
                    .font(.title)
            }
        }.sheet(isPresented: self.$showAddSheet) {
            self.destinationView
        }
    }
}

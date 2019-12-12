//
//  Tab.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/14.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct Tab: View {
    @EnvironmentObject var loginPermission: UserAuth
    @State private var currentTab = 1
    
    var body: some View {
        
        TabView(selection: $currentTab) {
            RestaurantListLocal()
                
                .tabItem {
                    Image(systemName: "house")
                    Text("My") }.tag(1)
            
            RestaurantListCloud()
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Cloud") }.tag(2)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search") }.tag(3)
            
            AboutView().tabItem {
                Image(systemName: "info")
                Text("About") }.tag(4)
        }
        
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}

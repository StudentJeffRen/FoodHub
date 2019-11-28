//
//  SearchView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/14.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import UIKit

struct SearchView: View {
    @State var searchText = ""
    @State var showCancelButton = false
    @EnvironmentObject var localData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchBar(searchText: $searchText, showCancelButton: $showCancelButton)
                    
                    if showCancelButton {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true)
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton).animation(.default)
                
                if searchText == "" {
                    Spacer()
                    Text("Hello")
                    Spacer()
                } else {
                    List {
                        ForEach(localData.restaurants.filter{$0.name.localizedCaseInsensitiveContains(searchText) || $0.type.localizedCaseInsensitiveContains(searchText)}, id: \.id) { searchResult in
                            RestaurantRow(restaurant: searchResult)
                        }
                    }
                }
                
            }
            .navigationBarTitle("Search")
//            .navigationBarItems(trailing: Button("test") {
//                print(self.allRestaurant)
//            })
            .resignKeyboardOnDragGesture()
        }
    }
    
    // 搜索逻辑
    // 使用CoreData注意修改这里 if-let，检查 optional
//    func filterContent(for searchText: String) {
//        searchResults = restaurantData.filter({ (restaurant) -> Bool in
//            let name = restaurant.name
//            let type = restaurant.type
//            let isMatch = name.localizedCaseInsensitiveContains(searchText) || type.localizedCaseInsensitiveContains(searchText)
//
//            return isMatch
//            })
//    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(UserData(from: allRestaurant))
    }
}


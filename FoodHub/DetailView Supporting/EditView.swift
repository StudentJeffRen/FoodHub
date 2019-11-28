//
//  EditView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/27.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var localData: UserData
    var restaurantIndex: Int
    @State private var name = ""
    @State private var type = ""
    @State private var location = ""
    @State private var phone = ""
    @State private var description = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "chevron.down.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding()
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Image("save")
                        .padding()
                        .onTapGesture {
                            self.localData.restaurants[self.restaurantIndex].name = self.name
                            self.localData.restaurants[self.restaurantIndex].type = self.type
                            self.localData.restaurants[self.restaurantIndex].location = self.location
                            self.localData.restaurants[self.restaurantIndex].phone = self.phone
                            self.localData.restaurants[self.restaurantIndex].description = self.description
                            
                            print("Modify successfully!")
                            self.presentationMode.wrappedValue.dismiss()
                    }
                }
                Spacer()
            }
            
            
            
            VStack(alignment: .leading) {
                Text("NAME:")
                    .font(.system(.title, design: .rounded))
                    .padding(.horizontal)
                
                FormField(fieldName: "Enter Name", fieldValue: $name)
                    .onAppear{
                        self.name = self.localData.restaurants[self.restaurantIndex].name
                }
                
                HStack {
                    Text("TYPE:")
                        .font(.system(.title, design: .rounded))
                        .padding(.horizontal)
                    
                    Text(type)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .onAppear {
                            self.type = self.localData.restaurants[self.restaurantIndex].type
                    }
                }
                
                HStack {
                    Button(action: {
                        self.type = "Xiang"
                    }) {
                        TypeTag(type: "Xiang")
                    }
                    
                    Button(action: {
                        self.type = "Chuan"
                    }) {
                        TypeTag(type: "Chuan")
                    }
                    
                    Button(action: {
                        self.type = "Yue"
                    }) {
                        TypeTag(type: "Yue")
                    }
                    
                    Button(action: {
                        self.type = "Fast Food"
                    }) {
                        TypeTag(type: "Fast Food")
                    }
                    
                    Button(action: {
                        self.type = "Lo Mein"
                    }) {
                        TypeTag(type: "Lo Mein")
                    }
                }.padding()
                
                Text("ADDRESS:")
                    .font(.system(.title, design: .rounded))
                    .padding(.horizontal)
                
                HStack {
                    Button(action: {
                        // get current location
                    }) {
                        Image(systemName: "location.fill")
                            .font(.title)
                    }
                    
                    FormField(fieldName: "Click the Button or Type", fieldValue: $location).onAppear{
                        self.location = self.localData.restaurants[self.restaurantIndex].location
                    }
                }.padding(.horizontal)
                
                Text("PHONE:")
                    .font(.system(.title, design: .rounded))
                    .padding(.horizontal)
                FormField(fieldName: "Enter Phone Number", fieldValue: $phone).onAppear{
                    self.phone = self.localData.restaurants[self.restaurantIndex].phone
                }
                
                Text("DESCRIPTION:")
                    .font(.system(.title, design: .rounded))
                    .padding(.horizontal)
                FormField(fieldName: "Describe the Restaurant", fieldValue: $description).onAppear{
                    self.description = self.localData.restaurants[self.restaurantIndex].description
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(restaurantIndex: 0).environmentObject(UserData(from: restaurantLocalData))
    }
}

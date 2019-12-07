//
//  NewName.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/25.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import CoreLocation

struct NewRestaurantView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var localData: UserData
    @EnvironmentObject var locationManager: LocationManager
    var newRestaurat = Restaurant()
    @State private var name = ""
    @State private var type = ""
    @State private var location = ""
    @State private var phone = ""
    @State private var description = ""
    @State private var showImagePicker = false
    @State private var image: Image? = nil
    @State private var showAlert = false
    
    var userLatitude: CLLocationDegrees {
        return locationManager.lastLocation?.coordinate.latitude ?? 0
    }
    var userLongitude: CLLocationDegrees {
        return locationManager.lastLocation?.coordinate.longitude ?? 0
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Group {
                    image?.resizable()
                }
                
                Group {
                    Text("NAME:")
                        .font(.system(.title, design: .rounded))
                        .padding(.horizontal)
                    
                    FormField(fieldName: "Enter Name", fieldValue: $name)
                    
                    HStack {
                        Text("TYPE:")
                            .font(.system(.title, design: .rounded))
                            .padding(.horizontal)
                        
                        Text(type)
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
                            self.getAddressFromLatLon(latitude: self.userLatitude, longitude: self.userLongitude) { addressString in
                                self.location = addressString
                            }
                        }) {
                            Image(systemName: "location.fill")
                                .font(.title)
                        }
                        FormField(fieldName: "Click the Button or Type", fieldValue: $location)
                    }.padding(.horizontal)
                    
                    Text("PHONE:")
                        .font(.system(.title, design: .rounded))
                        .padding(.horizontal)
                    FormField(fieldName: "Enter Phone Number(Optional)", fieldValue: $phone)
                    
                    Text("DESCRIPTION:")
                        .font(.system(.title, design: .rounded))
                        .padding(.horizontal)
                    FormField(fieldName: "Describe the Restaurant(Optional)", fieldValue: $description)
                }
                
                Group {
                    HStack {
                        Text("SELECT PHOTO:")
                            .font(.system(.title, design: .rounded))
                            .padding(.horizontal)
                        
                        Button(action: {
                            withAnimation {
                                self.showImagePicker.toggle()
                            }
                        }) {
                            Image(systemName: "photo")
                                .font(.title)
                        }
                    }
                }
            }
            
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.title)
                            .foregroundColor((image == nil) ? .gray: .white)
                            .padding()
                    }
                    Spacer()
                    
                    Button(action: {
                        if(!(self.name == "" && self.type == "" && self.location == "")) {
                            // 必要信息不全
                            self.showAlert.toggle()
                        } else if(self.phone == "" || self.description == "") {
                            // 可选信息
                            if(self.description != "") {
                                self.newRestaurat.name = self.name
                                self.newRestaurat.type = self.type
                                self.newRestaurat.location = self.location
                                self.newRestaurat.description = self.description
                                self.localData.restaurants.append(self.newRestaurat)
                                self.presentationMode.wrappedValue.dismiss()
                            } else if(self.phone != "") {
                                self.newRestaurat.name = self.name
                                self.newRestaurat.type = self.type
                                self.newRestaurat.location = self.location
                                self.newRestaurat.phone = self.phone
                                self.localData.restaurants.append(self.newRestaurat)
                                self.presentationMode.wrappedValue.dismiss()
                            } else {
                                self.newRestaurat.name = self.name
                                self.newRestaurat.type = self.type
                                self.newRestaurat.location = self.location
                                self.localData.restaurants.append(self.newRestaurat)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            // 所有信息齐全
                            self.newRestaurat.name = self.name
                            self.newRestaurat.type = self.type
                            self.newRestaurat.location = self.location
                            self.newRestaurat.phone = self.phone
                            self.newRestaurat.description = self.description
                            self.localData.restaurants.append(self.newRestaurat)
                            print("Create successfully!")
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    }) {
                        Image(systemName: "folder.badge.plus")
                            .font(.title)
                            .foregroundColor((image == nil) ? .black : .white)
                            .padding()
                            
                    }
                }
                Spacer()
            }
            
            if(showImagePicker) {
                CaptureImageView(isShown: $showImagePicker, image: $image)
                    .transition(.move(edge: .bottom))
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"), message: Text("Fill in all necessary field"), dismissButton: .default(Text("OK")))
        }
    }
    
    func getAddressFromLatLon(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping(String)->()) {
        let geoCoder: CLGeocoder = CLGeocoder()
        
        let location: CLLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    var addressString : String = ""
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country!
                    }
                    
                    print(addressString)
                    completion(addressString)
                }
        })
    }
}

struct NewName_Previews: PreviewProvider {
    static var previews: some View {
        NewRestaurantView()
    }
}

struct TypeTag: View {
    var type: String
    var body: some View {
        Text("#\(type)")
            .padding(EdgeInsets(top: 5, leading: 4, bottom: 5, trailing: 4))
            .foregroundColor(.white)
            .background(Color(.lightGray))
            .cornerRadius(15)
    }
}

//
//  EditView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/27.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import CoreLocation

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var localData: LocalList
    @Binding var restaurant: Restaurant
    @State private var name = ""
    @State private var type = ""
    @State private var location = ""
    @State private var phone = ""
    @State private var description = ""
    
    var userLatitude: CLLocationDegrees {
        return locationManager.lastLocation?.coordinate.latitude ?? 0
    }
    var userLongitude: CLLocationDegrees {
        return locationManager.lastLocation?.coordinate.longitude ?? 0
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.down.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.restaurant.name = self.name
                        self.restaurant.type = self.type
                        self.restaurant.location = self.location
                        self.restaurant.phone = self.phone
                        self.restaurant.description = self.description
                        self.localData.updateRestaurnat(self.restaurant)
                        
                        print("Modify successfully!")
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("save")
                            .padding()
                    }
                }
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Group {
                    Text("NAME:")
                        .font(.system(.title, design: .rounded))
                    FormField(fieldName: "Enter Name", fieldValue: $name)
                    
                    HStack {
                        Text("TYPE:")
                            .font(.system(.title, design: .rounded))
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
                    }.padding(.vertical)
                    
                    Text("ADDRESS:")
                        .font(.system(.title, design: .rounded))
                    
                    
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
                    }
                    
                    Text("PHONE:")
                        .font(.system(.title, design: .rounded))
                    
                    FormField(fieldName: "Enter Phone Number(Optional)", fieldValue: $phone)
                    
                    Text("DESCRIPTION:")
                        .font(.system(.title, design: .rounded))
                    
                    FormField(fieldName: "Describe the Restaurant(Optional)", fieldValue: $description)
                }.padding(.horizontal)
                
            }
        }
        .onAppear {
            self.name = self.restaurant.name
            self.type = self.restaurant.type
            self.location = self.restaurant.location
            self.phone = self.restaurant.phone
            self.description = self.restaurant.description
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




//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(restaurantIndex: 0).environmentObject(UserData(from: restaurantLocalData))
//    }
//}

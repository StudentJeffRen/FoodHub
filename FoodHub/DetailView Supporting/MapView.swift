//
//  MapView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/28.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var location: String
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let geoCoder = CLGeocoder()
        
        print(location)
        
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    view.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    view.setRegion(region, animated: true)
                }
            }
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(location: "Macau University of Science and Technology")
    }
}

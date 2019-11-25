//
//  MapView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/12.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate = CLLocationCoordinate2D(latitude: 113.539166, longitude: 22.2175)

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        // 原本是在这里手动输入经纬度 coordinate
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}


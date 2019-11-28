//
//  FullScreenMapView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/28.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct FullScreenMapView: View {
    @Environment(\.presentationMode) var presentationMode
    var location: String
    
    var body: some View {
        MapView(location: location)
        .overlay(Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left.circle.fill")
                .font(.title)
                .foregroundColor(.gray)
                .padding()
        }, alignment: .topLeading)
    }
}

struct FullScreenMapView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenMapView(location: "华发世纪城")
    }
}

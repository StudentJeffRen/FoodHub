//
//  RatingView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/26.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @Binding var restaurant: Restaurant
    @EnvironmentObject var localData: LocalList
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            blurBackground()
                .overlay(
                    Image(systemName: "chevron.down.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                    }
                    , alignment: .topTrailing)
            
            VStack(alignment: .leading) {
                Emotion(emotion: "love", restaurant: $restaurant)
                Emotion(emotion: "happy", restaurant: $restaurant)
                Emotion(emotion: "cool", restaurant: $restaurant)
                Emotion(emotion: "sad", restaurant: $restaurant)
                Emotion(emotion: "angry", restaurant: $restaurant)
            }
        }

        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
}

//struct RatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        RatingView(restaurant: 0)
//    }
//}

struct Emotion: View {
    var emotion: String
    @Binding var restaurant: Restaurant
    @EnvironmentObject var localData: LocalList
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Image(emotion)
            Text(emotion.capitalized)
                .font(.largeTitle)
                .foregroundColor(.white)
        }.onTapGesture {
            self.restaurant.rating = self.emotion
            self.localData.updateRestaurnat(self.restaurant)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct blurBackground: View {
    var body: some View {
        Rectangle()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .foregroundColor(.gray)
            .blur(radius: 40)
            .edgesIgnoringSafeArea(.all)
    }
}

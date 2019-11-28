//
//  RatingView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/26.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    var restaurantIndex: Int
    @EnvironmentObject var localData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .foregroundColor(.gray)
                .blur(radius: 40)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Emotion(emotion: "love", restaurantIndex: restaurantIndex)
                Emotion(emotion: "happy", restaurantIndex: restaurantIndex)
                Emotion(emotion: "cool", restaurantIndex: restaurantIndex)
                Emotion(emotion: "sad", restaurantIndex: restaurantIndex)
                Emotion(emotion: "angry", restaurantIndex: restaurantIndex)
            }            
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                    }
                }
                Spacer()
            }
        }
            
            
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(restaurantIndex: 0)
    }
}

struct Emotion: View {
    var emotion: String
    var restaurantIndex: Int
    @EnvironmentObject var localData: UserData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Image(emotion)
            Text(emotion.capitalized)
                .font(.largeTitle)
                .foregroundColor(.white)
        }.onTapGesture {
            self.localData.restaurants[self.restaurantIndex].rating = self.emotion
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

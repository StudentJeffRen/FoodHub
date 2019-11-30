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
                    Image(systemName: "chevron.down.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .onTapGesture {
                            self.presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
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
            switch self.emotion {
            case "love": self.localData.restaurants[self.restaurantIndex].ratingRow[0] += 1
            case "happy": self.localData.restaurants[self.restaurantIndex].ratingRow[1] += 1
            case "cool": self.localData.restaurants[self.restaurantIndex].ratingRow[2] += 1
            case "sad":
                self.localData.restaurants[self.restaurantIndex].ratingRow[3] += 1
            case "angry": self.localData.restaurants[self.restaurantIndex].ratingRow[4] += 1
            default:
                break
            }
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

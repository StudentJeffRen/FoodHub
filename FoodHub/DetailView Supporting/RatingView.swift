//
//  RatingView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/26.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @Binding var selectedEmotion: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .foregroundColor(.gray)
                .blur(radius: 40)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Emotion(emotion: "love").onTapGesture {
                    self.selectedEmotion = "love"
                    self.presentationMode.wrappedValue.dismiss()
                }
                Emotion(emotion: "happy").onTapGesture {
                    self.selectedEmotion = "happy"
                    self.presentationMode.wrappedValue.dismiss()
                }
                Emotion(emotion: "cool").onTapGesture {
                    self.selectedEmotion = "cool"
                    self.presentationMode.wrappedValue.dismiss()
                }
                Emotion(emotion: "sad").onTapGesture {
                    self.selectedEmotion = "sad"
                    self.presentationMode.wrappedValue.dismiss()
                }
                Emotion(emotion: "angry").onTapGesture {
                    self.selectedEmotion = "angry"
                    self.presentationMode.wrappedValue.dismiss()
                }
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
        RatingView(selectedEmotion: .constant("happy"))
    }
}

struct Emotion: View {
    var emotion: String
    var body: some View {
        HStack {
            Image(emotion)
            Text(emotion.capitalized)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

//
//  WeChatView.swift
//  FoodHub
//
//  Created by helen on 2019/10/18.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct WeChatView: View {
    var body: some View {
        HStack {
            VStack{
            Image("jie_teacher")
                .resizable()
                .frame(width: 220, height: 220)
                .offset(x: -20, y: -120)
                
            }
            
            Image("add_jeff")
            .resizable()
            .frame(width: 220, height: 260)
            .offset(x: -220, y: 120)
        }
        
    }
}

struct WeChatView_Previews: PreviewProvider {
    static var previews: some View {
        WeChatView()
    }
}

//
//  StartView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/26.
//  Copyright © 2019 JeffRen. All rights reserved.
//
import SwiftUI

struct StartView: View {
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if(session.session != nil) {
                Tab()
            } else {
                LoginView().environmentObject(session)
            }
        }.onAppear(perform: getUser)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

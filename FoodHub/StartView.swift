//
//  StartView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/11/26.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var loginPermission: UserAuth
    
    var body: some View {
        if loginPermission.isLogin {
            return AnyView(Tab())
        } else {
            return AnyView(LoginView())
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

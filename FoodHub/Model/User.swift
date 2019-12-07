//
//  User.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/25.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}



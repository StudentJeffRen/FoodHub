//
//  User.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/25.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import Foundation
import CoreData


public class User: NSManagedObject, Identifiable {
    @NSManaged public var userId: String?
    @NSManaged public var password: String?
}

extension User {
    // ❇️ The @FetchRequest property wrapper in the ContentView will call this function
    static func allUsersFetchRequest() -> NSFetchRequest<User> {
        let request: NSFetchRequest<User> = User.fetchRequest() as! NSFetchRequest<User>
        
        // ❇️ The @FetchRequest property wrapper in the ContentView requires a sort descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "userId", ascending: true)]
          
        return request
    }
}

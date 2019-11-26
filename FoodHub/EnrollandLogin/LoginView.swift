//
//  ContentView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/10.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

enum ActiveAlert {
    case noId, passwordNotMatch, notComplete
}

struct LoginView: View {
    @EnvironmentObject var loginPermission: UserAuth
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: User.allUsersFetchRequest()) var users: FetchedResults<User>
    
    @State private var userId = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .noId
    @State private var showAddSheet = false
    
    var body: some View {
        VStack {
            Image("foodpin-logo")
                .padding(.bottom, 70)
            
            VStack {
                VStack(spacing: 50) {
                    FormField(fieldName: "Username", fieldValue: $userId)
                    FormField(fieldName: "Password", fieldValue: $password, isSecure: true)
                    
                }.padding()
                
                VStack(spacing: 10) {
                    Button(action: {self.checkLogin()}) {
                        standardButton(text: "Sign in")
                    }
                    .padding(.top, 50)
                    .alert(isPresented: $showAlert) {
                        switch activeAlert {
                        case .noId:
                            return Alert(title: Text("Oops"), message: Text("No such account"), dismissButton: .default(Text("Got it")))
                        case .passwordNotMatch:
                            return Alert(title: Text("Oops"), message: Text("Password does not match"), dismissButton: .default(Text("Got it")))
                        case .notComplete:
                            return Alert(title: Text("Oops"), message: Text("Fill all blanks"), dismissButton: .default(Text("Got it")))
                        }
                    }
                    
                    Button(action: {
                        print("Button Pushed")
                        self.showAddSheet.toggle()
                        print(self.showAddSheet)
                    }) {
                        standardButton(text: "Register")
                    }.sheet(isPresented: self.$showAddSheet) {
                        EnrollView().environment(\.managedObjectContext, self.context!)
                    }
                }
            }
            .padding()
        }
    }
    
    // 比较账号密码，无账号，密码错误，弹窗
    func checkLogin() {
        var allIds: [String] = []
        for index in 0..<users.count {
            if let id = users[index].userId {
                allIds.append(id)
            }
        }
        
        var passwordIsMatch: Bool {
            if let currentUserIndex = allIds.firstIndex(of: userId) {
                return (password == users[currentUserIndex].password)
            }
            return false
        }
        
        if userId.isEmpty || password.isEmpty {
            self.activeAlert = .notComplete
            self.showAlert.toggle()
        }
        else if !allIds.contains(userId) {
            self.activeAlert = .noId
            self.showAlert.toggle()
        }
        else if !passwordIsMatch {
            self.activeAlert = .passwordNotMatch
            self.showAlert.toggle()
        }
        else {
            withAnimation {
                self.loginPermission.isLogin = true
            }
            print("Hello")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

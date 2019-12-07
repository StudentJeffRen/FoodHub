//
//  ContentView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/10.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import FirebaseAuth

enum ActiveAlert {
    case noId, passwordNotMatch, notComplete
}

struct LoginView: View {
    @EnvironmentObject var session: SessionStore
    
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .noId
    @State private var showAddSheet = false
    @State var loading = false
    
    
    func signIn() {
        if email.isEmpty || password.isEmpty {
            self.activeAlert = .notComplete
            self.showAlert.toggle()
        }
        
        loading = true
        
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                // 有哪些错误类型？处理弹窗
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    print(errCode.errorMessage)
                }
                
                print(error!)
            } else {
                print("should go to tab view")
                self.email = ""
                self.password = ""
            }
        }
    }
    
        // 比较账号密码，无账号，密码错误，弹窗
    //    func checkLogin() {
    //
    //        else if !allIds.contains(userId) {
    //            self.activeAlert = .noId
    //            self.showAlert.toggle()
    //        }
    //        else if !passwordIsMatch {
    //            self.activeAlert = .passwordNotMatch
    //            self.showAlert.toggle()
    //        }
    //        else {
    //            withAnimation {
    //                self.loginPermission.isLogin = true
    //            }
    //            print("Hello")
    //        }
    //    }
    
    var body: some View {
        VStack {
            Image("foodpin-logo")
                .padding(.bottom, 70)
            
            VStack {
                VStack(spacing: 50) {
                    FormField(fieldName: "Email", fieldValue: $email)
                    FormField(fieldName: "Password", fieldValue: $password, isSecure: true)
                    
                }.padding()
                
                VStack(spacing: 10) {
                    Button(action: { self.signIn() }) {
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
                        EnrollView().environmentObject(self.session)
                    }
                }
            }
            .padding()
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .userNotFound:
            return "This account didn't register"
        case .networkError:
            return "Network error"
        case .wrongPassword:
            return "Wrong password"
        case .invalidEmail:
            return "Invalid email format"
        case .emailAlreadyInUse:
            return "The email address is already in use"
        case .weakPassword:
            return "The password is too weak"
        default:
            return "Unknown Error"
        }
    }
}

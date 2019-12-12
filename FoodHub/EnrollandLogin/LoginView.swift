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
    case firebaseError, notComplete, localError
}

struct LoginView: View {
    @EnvironmentObject var session: SessionStore
    
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .firebaseError
    @State private var showAddSheet = false
    @State private var errorMessage = "Unknown Error"
    @State var loading = false
    
    
    func signIn() {
        if email.isEmpty || password.isEmpty {
            self.activeAlert = .notComplete
            self.showAlert.toggle()
        } else {
            loading = true
            
            session.signIn(email: email, password: password) { (result, error) in
                self.loading = false
                if error != nil {
                    // 有哪些错误类型？处理弹窗
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        print(errCode.errorMessage)
                        self.activeAlert = .firebaseError
                        self.errorMessage = errCode.errorMessage
                        self.showAlert.toggle()
                    }
                    
                    print(error!)
                } else {
                    print("should go to tab view")
                    self.email = ""
                    self.password = ""
                }
            }
        }
    }
    
    var body: some View {
        LoadingView(isShowing: $loading) {
            VStack {
                Image("foodpin-logo")

                VStack {
                    VStack(spacing: 50) {
                        FormField(fieldName: "Email", fieldValue: self.$email)
                        FormField(fieldName: "Password", fieldValue: self.$password, isSecure: true)
                        
                    }.padding()
                    
                    VStack(spacing: 10) {
                        Button(action: { self.signIn() }) {
                            standardButton(text: "Sign in")
                        }
                        .padding(.top, 50)

                        HStack {
                            Text("New Here?")
                                .font(.system(.body, design: .rounded))
                                .bold()
                            
                            Button(action: {
                                print("Button Pushed")
                                self.showAddSheet.toggle()
                                print(self.showAddSheet)
                            }) {
                                Text("Sign Up")
                                .font(.system(.body, design: .rounded))
                                .bold()
                                .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                            }.sheet(isPresented: self.$showAddSheet) {
                                EnrollView().environmentObject(self.session)
                            }
                        }.padding(.top)
                        
                    }
                }
                .padding()
            }
            .resignKeyboardOnDragGesture()
        }
        .alert(isPresented: self.$showAlert) {
            switch self.activeAlert {
            case .notComplete:
                return Alert(title: Text("Oops"), message: Text("Fill all blanks"), dismissButton: .default(Text("Got it")))
            default:
                return Alert(title: Text("Oops"), message: Text(self.errorMessage), dismissButton: .default(Text("Got it")))
            }
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

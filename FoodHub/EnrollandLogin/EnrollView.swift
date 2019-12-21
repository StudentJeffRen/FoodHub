//
//  EnrollView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/23.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import Firebase

/*
 1. 有空白
 2. 邮箱格式不合法
 3. 重复密码不匹配
 4. 密码太弱
 5. 邮箱已注册
 */

struct EnrollView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var session: SessionStore

    @ObservedObject private var userRegistrationViewModel = UserRegistrationViewModel()

    @State private var showAlert = false
    @State private var activeAlert: ActiveAlert = .notComplete
    @State private var loading = false
    @State private var errorMessage = "Unknown Error"
    
    func signUp() {
        if(userRegistrationViewModel.email.isEmpty || userRegistrationViewModel.username.isEmpty || userRegistrationViewModel.password.isEmpty || userRegistrationViewModel.passwordConfirm.isEmpty) {
            self.activeAlert = .notComplete
            self.showAlert.toggle()
        } else if (!userRegistrationViewModel.isPasswordCapitalLetter && !userRegistrationViewModel.isPasswordLengthValid && !userRegistrationViewModel.isPasswordConfirmValid) {
            self.activeAlert = .localError
            self.showAlert.toggle()
        } else {
            loading = true
            session.signUp(email: userRegistrationViewModel.email, password: userRegistrationViewModel.password) { (result, error) in
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
                    if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest() {
                        currentUser.displayName = self.userRegistrationViewModel.username
                        currentUser.commitChanges { error in
                            if error != nil {
                                print("There is an error", error!)
                                Auth.auth().currentUser?.delete { error in
                                    if let error = error {
                                        print("Network crashed, exit the app", error)
                                    } else {
                                        print("Re-sign up please")
                                    }
                                }
                            } else {
                                Firestore.firestore().collection("users").document(Auth.auth().currentUser?.uid ?? "unknown").setData(["name": self.userRegistrationViewModel.username])
                                print(Auth.auth().currentUser?.uid ?? "WHo are you?")
                                print("Name saved normally")
                                self.userRegistrationViewModel.email = ""
                                self.userRegistrationViewModel.username = ""
                                self.userRegistrationViewModel.password = ""
                                self.userRegistrationViewModel.passwordConfirm = ""
                                //                            self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        LoadingView(isShowing: $loading) {
            VStack {
                
                Text("Create an account")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                
                Group {
                    FormField(fieldName: "Email", fieldValue: self.$userRegistrationViewModel.email)
                    FormField(fieldName: "Username", fieldValue: self.$userRegistrationViewModel.username)
                    FormField(fieldName: "Password", fieldValue: self.$userRegistrationViewModel.password, isSecure: true)
                    FormField(fieldName: "Confirm Password", fieldValue: self.$userRegistrationViewModel.passwordConfirm, isSecure: true)
                }.padding()
                
                Group {
                    VStack {
                        RequirementText(iconName: "lock.open", iconColor: self.userRegistrationViewModel.isPasswordLengthValid ? Color.green : Color(red: 251/255, green: 128/255, blue: 128/255), text: "A minimum of 8 characters", goodInput: self.userRegistrationViewModel.isPasswordLengthValid, isSecure: true)
                        RequirementText(iconName: "lock.open", iconColor: self.userRegistrationViewModel.isPasswordCapitalLetter ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "One uppercase letter", goodInput: self.userRegistrationViewModel.isPasswordCapitalLetter, isSecure: true)
                        RequirementText(iconColor: self.userRegistrationViewModel.isPasswordConfirmValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "Your confirm password should be the same as password", goodInput: self.userRegistrationViewModel.isPasswordConfirmValid)
                            .padding(.bottom, 50)
                    }.padding()
                }
                
                Group {
                    // Sign up button
                    Button(action: {
                        self.signUp()
                    }) {
                        standardButton(text: "Sign up and Get Start!")
                    }
                    .alert(isPresented: self.$showAlert) {
                        switch(self.activeAlert) {
                        case .notComplete:
                            return Alert(title: Text("Oops!"), message: Text("Fill all blanks"), dismissButton: .default(Text("Got it")))
                        case .firebaseError:
                            return Alert(title: Text("Oops!"), message: Text(self.errorMessage), dismissButton: .default(Text("Got it")))
                        case .localError:
                            return Alert(title: Text("Oops!"), message: Text("Check your password"), dismissButton: .default(Text("Got it")))
                        }
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .font(.system(.body, design: .rounded))
                            .bold()
                        
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Sign in")
                                .font(.system(.body, design: .rounded))
                                .bold()
                                .foregroundColor(Color(red: 251/255, green: 128/255, blue: 128/255))
                        }
                    }.padding(.top)
                    
                    Spacer()
                }
                
            }
            .padding()
            .resignKeyboardOnDragGesture()
        }
    }
}


struct EnrollView_Previews: PreviewProvider {
    static var previews: some View {
        EnrollView()
    }
}

struct RequirementText: View {
    var iconName = "xmark.square"
    var iconColor = Color(red: 251/255, green: 128/255, blue: 128/255)
    
    var text = ""
    var goodInput = false
    var isSecure = false
    
    var body: some View {
        HStack {
            if (!goodInput) {
                Image(systemName: iconName)
                    .foregroundColor(iconColor)
            } else {
                if(isSecure) {
                    Image(systemName: "checkmark.shield")
                        .foregroundColor(.green)
                } else {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                }
            }
            Text(text)
            .font(.system(.body, design: .rounded))
            .foregroundColor(.secondary)
            Spacer()
        }
        .animation(.default)
    }
}

struct FormField: View {
    var fieldName = ""
    @Binding var fieldValue: String
    
    var isSecure = false
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(fieldName, text: $fieldValue)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
            } else {
                TextField(fieldName, text: $fieldValue)
                    .minimumScaleFactor(0.01)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
            }
            
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                
        }
    }
}

struct standardButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(.body, design: .rounded))
            .foregroundColor(.white)
            .bold()
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 128/255, blue: 128/255), Color(red: 253/255, green: 193/255, blue: 104/255)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

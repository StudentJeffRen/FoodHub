//
//  EnrollView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/23.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

enum AlertType {
    case SUCCESS, FAIL, DUPLICATE
}

struct EnrollView: View {
    @Environment(\.presentationMode) var presentationMode
    
    /* Core Data */
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: User.allUsersFetchRequest()) var users: FetchedResults<User>
    
    @ObservedObject private var userRegistrationViewModel = UserRegistrationViewModel()

    @State private var showAlert = false
    @State private var alertType = AlertType.FAIL
    
    var body: some View {
        VStack {
            Text("Creat an account")
                .font(.system(.largeTitle, design: .rounded))
                .bold()
                .padding(.bottom, 30)
            
            // ID
            FormField(fieldName: "Username", fieldValue: $userRegistrationViewModel.username)
            RequirementText(text: "A minimum of 4 characters", goodInput: userRegistrationViewModel.isUsernameLengthValid)
                .padding()
            
            // Password
            FormField(fieldName: "Password", fieldValue: $userRegistrationViewModel.password, isSecure: true)
            VStack {
                RequirementText(iconName: "lock.open", iconColor: userRegistrationViewModel.isPasswordLengthValid ? Color.green : Color(red: 251/255, green: 128/255, blue: 128/255), text: "A minimum of 8 characters", goodInput: userRegistrationViewModel.isPasswordLengthValid, isSecure: true)
                RequirementText(iconName: "lock.open", iconColor: userRegistrationViewModel.isPasswordCapitalLetter ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "One uppercase letter", goodInput: userRegistrationViewModel.isPasswordCapitalLetter, isSecure: true)
            }
            .padding()
            
            // Confirm password
            FormField(fieldName: "Confirm Password", fieldValue: $userRegistrationViewModel.passwordConfirm, isSecure: true)
            RequirementText(iconColor: userRegistrationViewModel.isPasswordConfirmValid ? Color.secondary : Color(red: 251/255, green: 128/255, blue: 128/255), text: "Your confirm password should be the same as password", goodInput: userRegistrationViewModel.isPasswordConfirmValid)
                .padding()
                .padding(.bottom, 50)
            
            // Sign up button
            Button(action: {
                self.registerCheck()
            }) {
                standardButton(text: "Sign up")
            }
            .alert(isPresented: self.$showAlert) {
                switch(alertType) {
                case .SUCCESS:
                    return Alert(title: Text("Congratulation"), message: Text("You can use this account to login."), dismissButton: .default(Text("Got it")) { self.presentationMode.wrappedValue.dismiss() })
                case .FAIL:
                    return Alert(title: Text("Oops!"), message: Text("Please check your input."), dismissButton: .default(Text("Got it")))
                case .DUPLICATE:
                    return Alert(title: Text("Oops!"), message: Text("The username is already existing, please try another one."), dismissButton: .default(Text("Got it")))
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
            }.padding(.top, 50)
            
            Spacer()
        }
    .padding()
    }
    
    func registerCheck() {
        showAlert.toggle()
        
        var allIds: [String] = []
        for index in 0..<users.count {
            if let id = users[index].userId {
                allIds.append(id)
            }
        }
        
        if allIds.contains(userRegistrationViewModel.username) {
            alertType = .DUPLICATE
        } else if(userRegistrationViewModel.isUsernameLengthValid && userRegistrationViewModel.isPasswordLengthValid &&
            userRegistrationViewModel.isPasswordCapitalLetter &&
            userRegistrationViewModel.isPasswordConfirmValid
            ) {
            // save to database
            let user = User(context: self.managedObjectContext)
            user.userId = self.userRegistrationViewModel.username
            user.password = self.userRegistrationViewModel.password
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }

            if !self.managedObjectContext.hasChanges {
                alertType = .SUCCESS
            }
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
                
                Text(text)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.secondary)
            
            } else {
                if(isSecure) {
                    Image(systemName: "checkmark.shield")
                        .foregroundColor(.green)
                } else {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                }
                
                Text("Perfect")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.secondary)
                
                
            }
            
            
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
                    .padding(.horizontal)
            } else {
                TextField(fieldName, text: $fieldValue)
                    .minimumScaleFactor(0.01)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .padding(.horizontal)
            }
            
            Divider()
                .frame(height: 1)
                .background(Color(red: 240/255, green: 240/255, blue: 240/255))
                .padding(.horizontal)
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

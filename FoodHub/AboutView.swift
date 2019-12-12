//
//  AboutView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/14.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import Firebase

struct AboutView: View {
    @EnvironmentObject var session: SessionStore
    @State var name: String = "Synchronizing Your Name..."
    
    var email: String {
        if let email = session.session?.email {
            return email
        } else {
            return "Unknown"
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Image("foodpin-logo")
                        .resizable()

                    VStack(alignment: .leading){
                        Text(name)
                            .font(.title)
                        Spacer()
                        Text(email)
                            .font(.subheadline)
                    }.padding()
                    
                }
                
                Section(header: Text("Follow us").font(.title)) {
                    
                    NavigationLink(destination: WeChatView()) {
                        shareRow(social: "WeChat")
                    }
                    
                    NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "https://github.com/StudentJeffRen")!))) {
                        shareRow(social: "Github")
                    }
                    
                    NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "http://jeffren.top")!))) {
                        shareRow(social: "Blog")
                    }
                    
                }
                
                Section{
                    Button(action: {
                        withAnimation {
                            print("Log out: \(self.session.signOut())")
                        }
                    }) {
                        Text("Log out")
                            .bold()
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("About")
        }
        .onAppear{
            let user = Auth.auth().currentUser
            if user?.displayName != nil {
                self.name = (user?.displayName)!
            } else {
                print("Something error")
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().environmentObject(SessionStore())
    }
}

struct shareRow: View {
    let social: String
    
    var body: some View {
        HStack {
            Image(social)
                .resizable()
                .frame(width: 30, height: 30)
                .cornerRadius(5)
            HStack {
                VStack {
                    Text(social)
                }
            }
        }
    }
}

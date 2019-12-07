//
//  AboutView.swift
//  FoodHub
//
//  Created by JeffRen on 2019/10/14.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Image("foodpin-logo")
                        .offset(x: 110, y: 0)
                        .padding(EdgeInsets(top: 50, leading: 20, bottom: 50, trailing: 20))
                    
                    informationRow()
                }
                
                Section(header: Text("Follow us").font(.title)) {
                    
                    NavigationLink(destination: WeChatView()) {
                        shareRow(social: "Wechat")
                    }
                    
                    NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))) {
                        shareRow(social: "Github")
                            
                    }
                    
                    NavigationLink(destination: WebView(request: URLRequest(url: URL(string: "jeffren.top")!))) {
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
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

struct shareRow: View {
    let social: String
    
    var body: some View {
        HStack {
            Image(social)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            HStack {
                VStack {
                    Text(social)
                }
            }
        }
    }
}

struct informationRow: View {
    var body: some View {
        HStack {
            Image("jeff")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack (alignment: .leading){
                Text("Jeff")
                    .font(.title)
                HStack {
                    Text("ID")
                        .font(.subheadline)
                    Spacer()
                    Text("17765995555")
                        .font(.subheadline)
                }
                .font(.subheadline)
            }
            
        }
        .padding()
    }
}

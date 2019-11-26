//
//  WebView.swift
//  FoodHub
//
//  Created by helen on 2019/10/18.
//  Copyright © 2019 JeffRen. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context)->WKWebView{
        return WKWebView()
        }
          
        func updateUIView(_ uiView: WKWebView, context: Context) {
            uiView.load(request)
    }
}

struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://www.apple.com")!))
    }
}



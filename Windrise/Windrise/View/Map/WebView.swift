//
//  WebView.swift
//  Windrise
//
//  Created by MacBook Pro on 06/06/22.
//

import Foundation
import SwiftUI
import WebKit
 
struct WebViewContainer: UIViewRepresentable {
    @ObservedObject var mapViewModel: MapViewModel
    
    func makeCoordinator() -> WebViewContainer.Coordinator {
        Coordinator(self, mapViewModel)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.mapViewModel.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if mapViewModel.shouldGoBack {
            uiView.goBack()
            mapViewModel.shouldGoBack = false
        }
    }
}

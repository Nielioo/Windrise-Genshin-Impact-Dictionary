//
//  WebViewContainer.swift
//  Windrise
//
//  Created by MacBook Pro on 06/06/22.
//

import Foundation
import SwiftUI
import WebKit

extension WebViewContainer {
    class Coordinator: NSObject, WKNavigationDelegate {
        @ObservedObject private var mapViewModel: MapViewModel
        private let parent: WebViewContainer
        
        init(_ parent: WebViewContainer, _ mapViewModel: MapViewModel) {
            self.parent = parent
            self.mapViewModel = mapViewModel
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            mapViewModel.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            mapViewModel.isLoading = false
            mapViewModel.title = webView.title ?? ""
            mapViewModel.canGoBack = webView.canGoBack
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            mapViewModel.isLoading = false
        }
    }
}

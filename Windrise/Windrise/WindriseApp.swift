//
//  WindriseApp.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

@main
struct WindriseApp: App {
    
    @StateObject var mainViewModel:MainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainViewModel)
        }
    }
}

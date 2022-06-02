//
//  WindriseApp.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

@main
struct WindriseApp: App {
    
    @StateObject private var dataController: DataController = DataController()
    @StateObject private var mainViewModel: MainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(mainViewModel)
        }
    }
}

//
//  ContentView.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case character
        case map
        case profile
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
            
            CharacterList()
                .tabItem {
                    Label("Character", systemImage: "sparkle")
                }
                .tag(Tab.character)
            
            GenshinMap()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
                .tag(Tab.map)
            
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.profile)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.white
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .environment(\.managedObjectContext, DataController().container.viewContext)
                .environmentObject(MainViewModel())
        }
    }
}

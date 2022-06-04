//
//  HomeViewModel.swift
//  Windrise
//
//  Created by MacBook Pro on 04/06/22.
//

import Foundation
import SwiftUI
import CoreData

class HomeViewModel: ObservableObject{
    @Published var bannerImages: [Image] = []
    
    private let bannerImagePath: [String] = ["yelanBanner27", "xiaoBanner27", "weaponBanner27"]
    
    init() {
        bannerImages = bannerImagePath.map { path in
            Image(path)
        }
    }
    
}

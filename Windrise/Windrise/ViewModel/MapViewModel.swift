//
//  MapViewModel.swift
//  Windrise
//
//  Created by MacBook Pro on 06/06/22.
//

import Foundation

class MapViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var shouldGoBack: Bool = false
    @Published var title: String = ""
    
    var url: String
    
    init(url: String) {
        self.url = url
    }
}

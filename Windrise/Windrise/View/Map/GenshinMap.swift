//
//  GenshinMap.swift
//  Windrise
//
//  Created by MacBook Pro on 06/06/22.
//

import SwiftUI

struct GenshinMap: View {
    
    @ObservedObject var mapViewModel = MapViewModel(url: "https://act.hoyolab.com/ys/app/interactive-map/index.html")
    
    var body: some View {
        
//        NavigationView {
        ZStack {
            WebViewContainer(mapViewModel: mapViewModel)
            if mapViewModel.isLoading {
                ProgressBar()
                    .frame(height: 30)
            }
        }.background(.ultraThinMaterial)
//            .navigationBarTitle(Text(mapViewModel.title), displayMode: .inline)
//            .navigationBarItems(leading: Button(action: {
//                mapViewModel.shouldGoBack.toggle()
//            }, label: {
//                if mapViewModel.canGoBack {
//                    Image(systemName: "arrow.left")
//                        .frame(width: 44, height: 44, alignment: .center)
//                        .foregroundColor(.black)
//                } else {
//                    EmptyView()
//                        .frame(width: 0, height: 0, alignment: .center)
//                }
//            })
//            )
//        }
        
    }
}

struct GenshinMap_Previews: PreviewProvider {
    static var previews: some View {
        GenshinMap()
    }
}

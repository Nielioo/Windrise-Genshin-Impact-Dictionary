//
//  FeaturedCard.swift
//  Windrise
//
//  Created by MacBook Pro on 04/06/22.
//

import SwiftUI

struct FeaturedCard: View {
    
    var banner: Image
    
    var body: some View {
        banner
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct FeaturedCard_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCard(banner: Image("yelanBanner27"))
    }
}

//
//  ProgressBar.swift
//  Windrise
//
//  Created by MacBook Pro on 06/06/22.
//

import SwiftUI

struct ProgressBar: View {
    var body: some View {
        ProgressItem(tintColor: .indigo, scaleSize: 1.5)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar()
    }
}

struct ProgressItem: View {
    var tintColor: Color = .blue
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ProgressView()
            .scaleEffect(scaleSize, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
    }
}

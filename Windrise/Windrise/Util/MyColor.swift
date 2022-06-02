//
//  MyColor.swift
//  Windrise
//
//  Created by MacBook Pro on 02/06/22.
//

import Foundation
import QuartzCore
import SwiftUI

private let customOrange: Color = rgbToColor(red: 255, green: 138, blue: 1)
private let customLightGreen: Color = rgbToColor(red: 0, green: 255, blue: 148)
private let customLightBlue: Color = rgbToColor(red: 60, green: 161, blue: 255)

func rgbToColor(red: Double, green: Double, blue: Double) -> Color {
    return Color(red: red / 255, green: green / 255, blue: blue / 255)
}

struct MyColor{
    
    static let mainBackground = LinearGradient(
        gradient: Gradient(
            colors: [Color("BackgroundDarkBlue"),Color("BackgroundDarkPurple")]),
        startPoint: .topLeading,
        endPoint: .bottomLeading)
    
    static let favoriteActiveBackground = LinearGradient(
        gradient: Gradient(
            colors: [customOrange,.red]),
        startPoint: .topLeading,
        endPoint: .bottomLeading)
    
    static let ownedActiveBackground = LinearGradient(
        gradient: Gradient(
            colors: [customLightGreen, customLightBlue]),
        startPoint: .topLeading,
        endPoint: .bottomLeading)
    
}



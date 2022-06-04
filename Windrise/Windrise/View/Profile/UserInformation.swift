//
//  UserInformation.swift
//  Windrise
//
//  Created by MacBook Pro on 04/06/22.
//

import SwiftUI

struct UserInformation: View {
    
    var name: String
    var profilePicture: Image
    
    var body: some View {
        
        VStack(spacing: 10){
            ZStack(alignment: .bottomTrailing){
                profilePicture
                    .resizable()
                    .frame(width:120, height: 120)
                    .clipShape(Circle())
//                Image(systemName: "pencil")
//                    .foregroundColor(.white)
//                    .frame(width: 30, height: 30)
//                    .background(Color.blue)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
            }
            Text(name)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
        }
        .padding(.top)
    
    }
}

struct UserInformation_Previews: PreviewProvider {
    static var previews: some View {
        UserInformation(name: "Windrise", profilePicture: Image("DefaultProfilePicture"))
    }
}

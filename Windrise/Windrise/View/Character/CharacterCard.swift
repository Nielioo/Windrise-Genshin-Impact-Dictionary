//
//  CharacterCard.swift
//  Windrise
//
//  Created by MacBook Pro on 24/05/22.
//

import SwiftUI

struct CharacterCard: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    var currentNameId: String
    var currentCharacter: Character
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                Image("BackgroundItem\(currentCharacter.rarity.description)Star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                mainViewModel.characterIconBig[currentNameId]?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .aspectRatio(1, contentMode: .fit)
            .overlay (alignment: .topLeading){
                if (!currentCharacter.vision.isEmpty){
                    mainViewModel.elementsIcon[currentCharacter.visionKey.lowercased()]?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .padding(3)
                }
            }
            
            VStack {
                Text(currentCharacter.name)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 30)
            .padding(.horizontal, 8)
            .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(2)
    }
}

struct CharacterCard_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCard(currentNameId: "ayaka", currentCharacter: Character(name: "Kamisato Ayaka"))
            .environmentObject(MainViewModel())
    }
}

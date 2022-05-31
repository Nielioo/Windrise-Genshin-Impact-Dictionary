//
//  CharacterCard.swift
//  Windrise
//
//  Created by MacBook Pro on 24/05/22.
//

import SwiftUI

struct CharacterCard: View {
    
    @EnvironmentObject var characterViewModel: CharacterViewModel
    var currentCharacter: Character
    var currentCharacterName: String
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                Image("BackgroundItem\(currentCharacter.rarity.description)Star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                characterViewModel.characterIconBig[currentCharacterName]?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .aspectRatio(1, contentMode: .fit)
            .overlay (alignment: .topLeading){
                if (!currentCharacter.vision.isEmpty){
                    characterViewModel.elementsIcon[currentCharacter.visionKey.lowercased()]?
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
            .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(2)
    }
}

struct CharacterCard_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCard(currentCharacter: Character(name:"Kamisato Ayaka"), currentCharacterName: "ayaka")
            .environmentObject(CharacterViewModel())
    }
}

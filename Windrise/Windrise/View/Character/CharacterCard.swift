//
//  CharacterCard.swift
//  Windrise
//
//  Created by MacBook Pro on 24/05/22.
//

import SwiftUI

struct CharacterCard: View {
    @State var currentCharacter: Character
    @State var currentCharacterName: String
    @State var currentCharacterElementIcon: Image = Image("")
    @State var currentCharacterIconBig: Image = Image("")
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                Image("BackgroundItem\(currentCharacter.rarity.description)Star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                currentCharacterIconBig
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .aspectRatio(1, contentMode: .fit)
            .overlay (alignment: .topLeading){
                if (!currentCharacter.vision.isEmpty){
                currentCharacterElementIcon
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
        .onAppear{
            Api().getCharacter(currentCharacterName: currentCharacterName) { character in
                self.currentCharacter = character
                
                Api().getCharacterElementIcon(currentCharacterVisionKey: currentCharacter.visionKey.lowercased()) { image in
                    self.currentCharacterElementIcon = image
                }
            }
            
            Api().getCharacterIconBig(currentCharacterName: currentCharacterName) { image in
                self.currentCharacterIconBig = image
            }
        }
    }
}

struct CharacterCard_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCard(currentCharacter: Character(name: "Kamisato Ayaka"), currentCharacterName: "yae-miko")
    }
}

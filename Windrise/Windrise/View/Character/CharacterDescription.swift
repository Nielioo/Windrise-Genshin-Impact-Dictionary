//
//  CharacterDescription.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

struct CharacterDescription: View {
    
    @State var currentCharacter: Character
    @State var currentCharacterGachaSplash: Image = Image("characterDummy")
    
    var body: some View {
        ScrollView {
            VStack {
                currentCharacterGachaSplash
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(currentCharacter.name)
                Text(currentCharacter.nation)
            }
            .onAppear{
                Api().getCharacter(currentCharacterName: currentCharacter.name) { character in
                    self.currentCharacter = character
                }
                
                Api().getCharacterGachaSplash(currentCharacterName: currentCharacter.name) { image in
                    self.currentCharacterGachaSplash = image
                }
            }
        }
    }
}

struct CharacterDescription_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDescription(currentCharacter: Character(name: "albedo"))
    }
}

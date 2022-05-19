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
                VStack{
                    currentCharacterGachaSplash
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                VStack{
                    Text(currentCharacter.name)
                    Text(currentCharacter.rarity.description)
                    Text(currentCharacter.vision)
                    Text(currentCharacter.weapon)
                    Text(currentCharacter.birthday)
                    Text(currentCharacter.nation)
                    Text(currentCharacter.constellation)
                }
                
                VStack{
                    Text(currentCharacter.description)
                }
                
                
                VStack{
                    ForEach(currentCharacter.skillTalents){ skill in
                        VStack{
                            Text(skill.name)
                            Text(skill.description)
                            //Text(skill.type ?? "")
                        }
                    }
                }
                
                VStack{
                    ForEach(currentCharacter.passiveTalents){ passive in
                        VStack{
                            Text(passive.name)
                            Text(passive.description)
                        }
                    }
                }
                
                VStack{
                    ForEach(currentCharacter.constellations){ cons in
                        Text(cons.level?.description ?? "0")
                        Text(cons.name)
                        Text(cons.description)
                    }
                }
                
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

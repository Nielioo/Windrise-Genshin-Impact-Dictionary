//
//  CharacterList.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

struct CharacterList: View {
    
    @State var characters: [String] = []
    
    var body: some View {
        List(characters, id: \.self) { character in
            Text(character)
        }.onAppear{
            Api().getCharacters { (characters) in
                self.characters = characters
            }
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
    }
}

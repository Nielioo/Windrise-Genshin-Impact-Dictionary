//
//  CharacterViewModel.swift
//  Windrise
//
//  Created by MacBook Pro on 31/05/22.
//

import Foundation
import SwiftUI

public class CharacterViewModel: ObservableObject {
    //index name
    @Published var charactersName: [String] = []
    //full name
    @Published var characters: [Character] = []
    @Published var elementsIcon: [String:Image] = [:]
    @Published var characterIconBig: [String:Image] = [:]
    
    init(){
        getCharacterData()
    }
    
    public func getCharacterData(){
        Api().getCharactersName { arrayOfCharactersName in
            self.charactersName = arrayOfCharactersName
            
            for charactersName in arrayOfCharactersName {
                Api().getCharacterIconBig(currentCharacterName: charactersName) { image in
                    self.characterIconBig[charactersName] = image
                }
            }
        }
        
        Api().getAllCharacters { arrayOfCharacters in
            self.characters = arrayOfCharacters
            
            for character in arrayOfCharacters{
                Api().getCharacterElementIcon(currentCharacterVisionKey: character.visionKey.lowercased()) { image in
                    self.elementsIcon[character.visionKey.lowercased()] = image
                }
            }
        }
        
        
    }
    
}

//
//  CharacterViewModel.swift
//  Windrise
//
//  Created by MacBook Pro on 31/05/22.
//

import Foundation
import SwiftUI

public class MainViewModel: ObservableObject {
    @Published var nameId: [String] = []
    @Published var characters: [Character] = []
    @Published var elementsIcon: [String:Image] = [:]
    @Published var characterIconBig: [String:Image] = [:]
    
    init(){
        fetch()
    }
    
    public func fetch(){
        //MARK: get all character by their name id
        Api().getCharactersName { arrayOfNameId in
            self.nameId = arrayOfNameId
            
            for name in arrayOfNameId {
                //MARK: get character icon
                Api().getCharacterIconBig(nameId: name) { image in
                    self.characterIconBig[name] = image
                }
            }
        }
        
        //MARK: get all characters data
        Api().getAllCharacters { arrayOfCharacters in
            self.characters = arrayOfCharacters
            
            //MARK: get element icons
            for character in arrayOfCharacters{
                Api().getCharacterElementIcon(currentCharacterVisionKey: character.visionKey.lowercased()) { image in
                    self.elementsIcon[character.visionKey.lowercased()] = image
                }
            }
        }
        
    }
    
}

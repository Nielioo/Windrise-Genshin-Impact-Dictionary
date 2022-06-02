//
//  CharacterViewModel.swift
//  Windrise
//
//  Created by MacBook Pro on 02/06/22.
//

import Foundation
import SwiftUI
import CoreData

class CharacterDetailViewModel: ObservableObject {
    @Published var gachaSplash: Image = Image("travellerPortrait")
    @Published var isFavorite: Bool = false
    @Published var isOwned: Bool = false
    @Published var talentIcons:[String: Image] = [:]
    @Published var constellationIcons:[Int: Image] = [:]
    
    private let talentIndexes:[String] = ["na", "skill", "burst", "passive-0", "passive-1", "passive-2", "passive-misc"]
    
    func fetch(nameId: String) {
        // MARK: Get gacha splash
        Api().getCharacterGachaSplash(nameId: nameId) { image in
            self.gachaSplash = image
        }
        
        // MARK: Get talent icons
        for index in talentIndexes {
            Api().getCharacterTalentIcon(nameId: nameId, index: index, completion: { icon in
                self.talentIcons[index] = icon
            })
        }
        
        // MARK: Get constellation icons
        for i in 0..<7 {
            Api().getCharacterConstellationIcon(nameId: nameId, constellationNumber: i) { icon in
                self.constellationIcons[i] = icon
            }
        }
        
        // MARK: Get favorite status
//        let fetchFavoriteCharacters: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
//        fetchFavoriteCharacters.predicate = NSPredicate(format: "id = %@", id)
//
//        if let results = try? moc.fetch(fetchFavoriteCharacters) {
//            if results.count != 0 {
//                // Data exists
//                if let favoriteCharacter = results.first {
//                    self.isFavorite = favoriteCharacter.isFavorite
//                }
//            }
//        }
        
        // MARK: Get own status
//        let fetchOwnCharacters: NSFetchRequest<OwnCharacter> = OwnCharacter.fetchRequest()
//        fetchOwnCharacters.predicate = NSPredicate(format: "id = %@", id)
//        
//        if let results = try? moc.fetch(fetchOwnCharacters) {
//            if results.count != 0 {
//                // Data exists
//                if let ownCharacter = results.first {
//                    self.isOwned = ownCharacter.isOwned
//                }
//            }
//        }
    }
}

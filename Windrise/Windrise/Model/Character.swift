//
//  Character.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import Foundation

// MARK: - Character
struct Character: Codable, Identifiable {
    let id = UUID()
    var name: String = ""
    var vision: String = ""
    var weapon: String = ""
    var nation: String = ""
    var affiliation: String = ""
    var rarity: Int = 0
    var constellation: String = ""
    var birthday: String = ""
    var description: String = ""
    var skillTalents: [Constellation] = []
    var passiveTalents: [Constellation] = []
    var constellations: [Constellation] = []
    var visionKey: String = ""
    var weaponType: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name, vision, weapon, nation, affiliation, rarity, constellation, birthday
        case description = "description"
        case skillTalents, passiveTalents, constellations
        case visionKey = "vision_key"
        case weaponType = "weapon_type"
    }
}

// MARK: - Constellation
struct Constellation: Codable, Identifiable {
    let id = UUID()
    var name: String = ""
    var unlock: String = ""
    var description: String = ""
    var level: Int? = 0
    var type: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case name, unlock
        case description = "description"
        case level, type
    }
}

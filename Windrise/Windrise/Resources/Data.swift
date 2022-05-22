//
//  Data.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

class Api{
    
    let BASE_URL: String = "https://api.genshin.dev"
    
    func getCharacters(completion: @escaping ([String]) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let characters = try! JSONDecoder().decode([String].self, from: data!)
            
            DispatchQueue.main.async {
                completion(characters)
            }
        }
        .resume()
    }
    
    func getCharacter(currentCharacterName: String, completion: @escaping (Character) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(currentCharacterName)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            let character = try! JSONDecoder().decode(Character.self, from: data!)
            
            DispatchQueue.main.async {
                completion(character)
            }
            
        }
        .resume()
    }
    
    func getCharacterGachaSplash(currentCharacterName: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(currentCharacterName)/gacha-splash") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                let gachaSplash = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "characterDummy"))
                completion(gachaSplash)
            }
            
        }
        .resume()
    }
    
    func getCharacterElementIcon(currentCharacterVisionKey: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/elements/\(currentCharacterVisionKey)/icon") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                let elementIcon = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "cryoElement"))
                completion(elementIcon)
            }
            
        }
        .resume()
    }
    
}

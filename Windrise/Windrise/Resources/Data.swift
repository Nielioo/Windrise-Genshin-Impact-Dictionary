//
//  Data.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

class Api{
    
    let BASE_URL: String = "https://api.genshin.dev"
    
    //MARK: - All Characters
    func getCharactersName(completion: @escaping ([String]) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let characters = try! JSONDecoder().decode([String].self, from: data!)
            
            DispatchQueue.main.async {
                completion(characters)
            }
        }
        .resume()
    }
    
    func getAllCharacters(completion: @escaping ([Character]) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/all") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let allCharacters = try! JSONDecoder().decode([Character].self, from: data!)
            
            DispatchQueue.main.async {
                completion(allCharacters)
            }
        }
        .resume()
    }
    
    //MARK: - Character
    func getCharacter(currentCharacterName: String, completion: @escaping (Character) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(currentCharacterName)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                
                DispatchQueue.main.async {
                    completion(character)
                }
            }
            catch {
                print(error)
            }
            
        }
        .resume()
    }
    
    //MARK: - Gacha Splash
    func getCharacterGachaSplash(currentCharacterName: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(currentCharacterName)/gacha-splash") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                let gachaSplash = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "travelerPortrait"))
                completion(gachaSplash)
            }
            
        }
        .resume()
    }
    
    //MARK: - Character Icon
    func getCharacterIcon(currentCharacterName: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(currentCharacterName)/icon") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            
            DispatchQueue.main.async {
                let CharacterIcon = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "travelerPortrait"))
                completion(CharacterIcon)
            }
        }
        .resume()
    }
    
    func getCharacterIconBig(currentCharacterName: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(currentCharacterName)/icon-big") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            if(response?.mimeType != "image/webp"){
                self.getCharacterIcon(currentCharacterName: currentCharacterName){ image in
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    let CharacterIconBig = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "travelerPortrait"))
                    completion(CharacterIconBig)
                }
            }
        }
        .resume()
    }
    
    //MARK: - Element Icon
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
    
    //MARK: - Constellation Icon
    func getCharacterConstellation(currentCharacterName: String, constellationNumber: Int, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(currentCharacterName)/constellation-\(constellationNumber)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                let constellationIcon = Image(uiImage: UIImage(data: data) ?? UIImage(imageLiteralResourceName: "rainCutter"))
                completion(constellationIcon)
            }
            
        }
        .resume()
    }
}

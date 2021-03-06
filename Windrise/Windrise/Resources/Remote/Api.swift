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
    func getCharacter(nameId: String, completion: @escaping (Character) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(nameId)") else { return }
        
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
    func getCharacterGachaSplash(nameId: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(nameId)/gacha-splash") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {return}
            
            if(response?.mimeType != "image/webp"){
                let image = Image("travelerPortrait")
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                do{
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
            
        }
        .resume()
    }
    
    //MARK: - Character Icon
    func getCharacterIcon(nameId: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(nameId)/icon") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            
            if(response?.mimeType != "image/webp"){
                let image = Image("")
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                do{
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
        .resume()
    }
    
    func getCharacterIconBig(nameId: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(nameId)/icon-big") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {return}
            
            if(response?.mimeType != "image/webp"){
                self.getCharacterIcon(nameId: nameId){ image in
                    completion(image)
                }
            } else {
                do{
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
        .resume()
    }
    
    //MARK: - Element Icon
    func getCharacterElementIcon(currentCharacterVisionKey: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/elements/\(currentCharacterVisionKey)/icon") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {return}
            
            if(response?.mimeType != "image/webp"){
                let image = Image("cryoElement")
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                do{
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
            
        }
        .resume()
    }
    
    //MARK: - Talent Icon
    func getCharacterTalentIcon(nameId: String, index: String, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(nameId)/talent-\(index)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {return}
            
            if(response?.mimeType != "image/webp"){
                let image = Image("")
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                do{
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
            
        }
        .resume()
    }
    
    //MARK: - Constellation Icon
    func getCharacterConstellationIcon(nameId: String, constellationNumber: Int, completion: @escaping (Image) -> ()){
        guard let url = URL(string: "\(BASE_URL)/characters/\(nameId)/constellation-\(constellationNumber)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {return}
            
            if(response?.mimeType != "image/webp"){
                let image = Image("")
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                do{
                    guard let uiImage = UIImage(data: data) else {
                        return
                    }
                    
                    let image = Image(uiImage: uiImage)
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
            
        }
        .resume()
    }
}

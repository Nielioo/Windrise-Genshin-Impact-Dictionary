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
        guard let url = URL(string: BASE_URL + "/characters") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let characters = try! JSONDecoder().decode([String].self, from: data!)
            
            DispatchQueue.main.async {
                completion(characters)
            }
        }
        .resume()
    }
}

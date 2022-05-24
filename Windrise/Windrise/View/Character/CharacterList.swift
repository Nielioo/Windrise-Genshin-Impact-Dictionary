//
//  CharacterList.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

struct CharacterList: View {
    
    @State var characters: [Character] = []
    @State var charactersName: [String] = []
    
    private var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("BackgroundDarkBlue"), Color("BackgroundDarkPurple")]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: columns){
                        ForEach(characters.indices, id: \.self){ index in
                            NavigationLink(destination: CharacterDescription(currentCharacter: characters[index], currentCharacterName: charactersName[index])){
                                CharacterCard(currentCharacter: characters[index], currentCharacterName: charactersName[index])
                            }
                            .tag(characters[index].name)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }.onAppear{
                    Api().getCharactersName { arrayOfCharactersName in
                        self.charactersName = arrayOfCharactersName
                    }
                    
                    Api().getAllCharacters { arrayOfCharacters in
                        self.characters = arrayOfCharacters
                    }
                }
                .navigationTitle("Character List")
                .foregroundColor(.white)
            }
        }
        
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
    }
}

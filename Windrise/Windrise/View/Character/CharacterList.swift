//
//  CharacterList.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

struct CharacterList: View {
    
    @EnvironmentObject var characterViewModel: CharacterViewModel
    
    private var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("BackgroundDarkBlue"), Color("BackgroundDarkPurple")]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: columns){
                        ForEach(characterViewModel.characters.indices, id: \.self){ index in
                            NavigationLink(
                                destination:
                                    CharacterDescription(
                                        currentCharacter: characterViewModel.characters[index],
                                        currentCharacterName: characterViewModel.charactersName[index])){
                                            CharacterCard(
                                                currentCharacter: characterViewModel.characters[index],
                                                currentCharacterName: characterViewModel.charactersName[index])
                                        }
                                        .tag(characterViewModel.characters[index].name)
                                        .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
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
            .environmentObject(CharacterViewModel())
    }
}

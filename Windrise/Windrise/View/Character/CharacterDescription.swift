//
//  CharacterDescription.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

struct CharacterDescription: View {
    
    @State var currentCharacter: Character
    @State var currentCharacterGachaSplash: Image = Image("characterDummy")
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("BackgroundDarkBlue"), Color("BackgroundDarkPurple")]), startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .center) {
                    ZStack(alignment: .bottomTrailing){
                        // MARK: - Gacha Splash
                        VStack{
                            currentCharacterGachaSplash
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }.ignoresSafeArea()
                        // MARK: - Character Intro
                        VStack{
                            Text(currentCharacter.name).padding(.top, 12)
                            Text(currentCharacter.rarity.description)
                            Text(currentCharacter.vision)
                            Text(currentCharacter.weapon)
                            Text(currentCharacter.birthday)
                            Text(currentCharacter.nation)
                            Text(currentCharacter.constellation).padding(.bottom, 12)
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    }
                    
                    VStack{
                        Text(currentCharacter.description)
                    }
                    
                    
                    VStack{
                        ForEach(currentCharacter.skillTalents){ skill in
                            VStack{
                                Text(skill.name)
                                Text(skill.description)
                                //Text(skill.type ?? "")
                            }
                        }
                    }
                    
                    VStack{
                        ForEach(currentCharacter.passiveTalents){ passive in
                            VStack{
                                Text(passive.name)
                                Text(passive.description)
                            }
                        }
                    }
                    
                    VStack{
                        ForEach(currentCharacter.constellations){ cons in
                            Text(cons.level?.description ?? "0")
                            Text(cons.name)
                            Text(cons.description)
                        }
                    }
                    
                }
                .padding(.horizontal, 12.0)
                // MARK: - Api Settings
                .onAppear{
                    Api().getCharacter(currentCharacterName: currentCharacter.name) { character in
                        self.currentCharacter = character
                    }
                    
                    Api().getCharacterGachaSplash(currentCharacterName: currentCharacter.name) { image in
                        self.currentCharacterGachaSplash = image
                    }
                }
            }
        }
    }
}

struct CharacterDescription_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDescription(currentCharacter: Character(name: "albedo"))
    }
}

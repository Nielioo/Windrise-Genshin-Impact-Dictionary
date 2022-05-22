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
    @State var currentCharacterElementIcon: Image = Image("cryoElement")
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("BackgroundDarkBlue"), Color("BackgroundDarkPurple")]), startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea()
            ScrollView {
                
                ZStack(alignment: .bottomTrailing){
                    // MARK: - Gacha Splash
                    VStack{
                        currentCharacterGachaSplash
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }.ignoresSafeArea()
                    
                    // MARK: - Intro
                    VStack {
                        VStack{
                            Text(currentCharacter.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top, 12)
                            Text(currentCharacter.rarity.description)
                                .padding(.bottom, 12)
                        }
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.horizontal, 12.0)
                }
                
                VStack(alignment: .center) {
                    
                    // MARK: - Mini Description
                    VStack{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Vision")
                                    .fontWeight(.bold)
                                    .padding(.bottom,0.5)
                                Text("Nation")
                                    .fontWeight(.bold)
                                    .padding(.bottom,0.5)
                                Text("Weapon")
                                    .fontWeight(.bold)
                                    .padding(.bottom,0.5)
                                Text("Birthday")
                                    .fontWeight(.bold)
                            }
                            VStack(alignment: .leading){
                                HStack{
                                    VStack{
                                        currentCharacterElementIcon
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                    .frame(height: 20.0)
                                    Text(currentCharacter.vision)
                                        .padding(.bottom,0.5)
                                }
                                Text(currentCharacter.nation)
                                    .padding(.bottom,0.5)
                                Text(currentCharacter.weapon)
                                    .padding(.bottom,0.5)
                                Text(dateProcess(rawDate: currentCharacter.birthday))
                            }
                            .padding(.horizontal, 12.0)
                        }
                        .padding(.vertical, 12.0)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    
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
                .padding(.vertical, 8.0)
                // MARK: - Api Settings
                .onAppear{
                    Api().getCharacter(currentCharacterName: currentCharacter.name) { character in
                        self.currentCharacter = character
                    }
                    
                    Api().getCharacterGachaSplash(currentCharacterName: currentCharacter.name) { image in
                        self.currentCharacterGachaSplash = image
                    }
                    
                    Api().getCharacterElementIcon(currentCharacterVisionKey: currentCharacter.visionKey, completion: { image in
                        self.currentCharacterElementIcon = image
                    })
                }
            }
        }
    }
}

func dateProcess(rawDate: String) -> String{
    let DEFAULT_YEAR: String = "2000"
    
    let rawDate = rawDate.replacingOccurrences(of: "0000", with: DEFAULT_YEAR)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    guard let tmpDate = dateFormatter.date(from: rawDate) else { return rawDate}
    
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "dd MMMM"
    
    let finalDate = dateFormatter2.string(from: tmpDate)
    return finalDate
}

struct CharacterDescription_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDescription(currentCharacter: Character(name: "albedo"))
    }
}

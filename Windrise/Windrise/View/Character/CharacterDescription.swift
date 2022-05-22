//
//  CharacterDescription.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

struct CharacterDescription: View {
    
    //TODO: - element icon, tab selection
    
    @State var currentCharacter: Character
    @State var currentCharacterGachaSplash: Image = Image("characterDummy")
    @State var currentCharacterElementIcon: Image = Image("cryoElement")
    @State private var talentSelection: String = "Basic"
    
    let talentSelections:[String] = ["Basic","Skill","Burst"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("BackgroundDarkBlue"), Color("BackgroundDarkPurple")]), startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            ScrollView {
                
                ZStack(alignment: .bottomTrailing){
                    // MARK: - Gacha Splash
                    VStack(alignment: .center){
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
                                if(currentCharacter.birthday != nil){
                                    Text(dateProcess(rawDate: currentCharacter.birthday ?? "Unknown"))
                                } else {
                                    Text("Unknown")
                                }
                            }
                            .padding(.horizontal, 12.0)
                        }
                        .padding(.vertical, 12.0)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 4.0)
                    
                    // MARK: - Description
                    VStack{
                        VStack{
                            Text("Description")
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .padding(.bottom,0.5)
                            Text(currentCharacter.description)
                                .font(.system(size: 14))
                            
                            
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 4.0)
                    
                    // MARK: - Skill Talents
                    VStack{
                        VStack{
                            Text("Talents")
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .padding(.bottom,0.5)
                            
                            Picker("Tip Percentage", selection: $talentSelection){
                                ForEach(talentSelections, id: \.self){selection in
                                    Text(selection)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color(hue: 0.0, saturation: 0.0, brightness: 0.0, opacity: 0.3))
                            .cornerRadius(8.0)
                            
                            if(!currentCharacter.skillTalents.isEmpty){
                                switch(talentSelection){
                                case "Basic":
                                    let basic = currentCharacter.skillTalents[0]
                                    let basicSplit = basic.description.split(separator: "\n")
                                    
                                    Text(basic.name)
                                    VStack{
                                        ForEach(basicSplit.indices, id: \.self){ index in
                                            if(index % 2 == 0){
                                                Text(basicSplit[index])
                                                    .font(.title)
                                            } else {
                                                Text(basicSplit[index])
                                                    .font(.caption)
                                                    .padding(.bottom, 10)
                                            }
                                        }
                                    }
                                    
                                case "Skill":
                                    let skill = currentCharacter.skillTalents[1]
                                    let skillSplit = skill.description.split(separator: "\n")
                                    
                                    Text(skill.name)
                                    VStack{
                                        ForEach(skillSplit.indices, id: \.self){ index in
                                            if(index % 2 == 0){
                                                Text(skillSplit[index])
                                                    .font(.title)
                                            } else {
                                                Text(skillSplit[index])
                                                    .font(.caption)
                                                    .padding(.bottom, 10)
                                            }
                                        }
                                    }
                                    
                                case "Burst":
                                    let burst = currentCharacter.skillTalents[2]
                                    let burstSplit = burst.description.split(separator: "\n")
                                    
                                    Text(burst.name)
                                    VStack{
                                        ForEach(burstSplit.indices, id: \.self){ index in
                                            if(index % 2 == 0){
                                                Text(burstSplit[index])
                                                    .font(.title)
                                            } else {
                                                Text(burstSplit[index])
                                                    .font(.caption)
                                                    .padding(.bottom, 10)
                                            }
                                        }
                                    }
                                    
                                default:
                                    Text("No Data")
                                }
                                
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 4.0)
                    
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
                .onAppear{
                    // MARK: - Api Settings
                    Api().getCharacter(currentCharacterName: currentCharacter.name) { character in
                        self.currentCharacter = character
                        
                        Api().getCharacterElementIcon(currentCharacterVisionKey: currentCharacter.visionKey.lowercased()) { image in
                            self.currentCharacterElementIcon = image
                        }
                    }
                    
                    Api().getCharacterGachaSplash(currentCharacterName: currentCharacter.name) { image in
                        self.currentCharacterGachaSplash = image
                    }
                    
                    // MARK: - Segmented Picker Settings
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.white
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                    
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
        CharacterDescription(currentCharacter: Character(name: "aloy"))
    }
}

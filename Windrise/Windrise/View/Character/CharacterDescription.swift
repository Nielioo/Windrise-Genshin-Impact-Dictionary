//
//  CharacterDescription.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI
import CoreData

struct CharacterDescription: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var characterDetailViewModel: CharacterDetailViewModel = CharacterDetailViewModel()
    @State var currentNameId: String
    @State var currentCharacter: Character
//    @State var currentCharacterGachaSplash: Image = Image("travelerPortrait")
//    @State var currentCharacterElementIcon: Image = Image("cryoElement")
//    @State var currentCharacterTalentIcon: [String : Image] = [:]
    
//    @State var currentCharacterConstellationIcon: [Image] = []
    @State private var talentSelection: String = "Basic"
    @State var constellationStar: Int = 1
    
    let talentSelections:[String] = ["Basic","Skill","Burst"]
    
    var star:Image = Image(systemName: "star.fill")
    
    var maximumConstellation: Int = 6
    var constellationActive: Image = Image("ascensionActive")
    var constellationInactive: Image = Image("ascensionInactive")
    
    func rarityState(for number:Int) -> Image{
        return star
    }
    
    func constellationState(for number:Int) -> Image{
        if number > constellationStar{
            return constellationInactive
        } else {
            return constellationActive
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("BackgroundDarkBlue"), Color("BackgroundDarkPurple")]), startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea()
            
            ScrollView {
                
                ZStack(alignment: .bottomTrailing){
                    // MARK: - Gacha Splash
                    VStack(alignment: .center){
                        characterDetailViewModel.gachaSplash
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
                                .padding(.bottom, 2)
                            
                            HStack(alignment: .bottom){
                                ForEach(1..<currentCharacter.rarity+1, id: \.self){ number in
                                    rarityState(for: number)
                                        .foregroundColor(Color.yellow)
                                }
                            }
                            .padding(.bottom, 10)
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
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .padding(.bottom,0.5)
                                Text("Nation")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .padding(.bottom,0.5)
                                Text("Weapon")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .padding(.bottom,0.5)
                                Text("Birthday")
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                            }
                            VStack(alignment: .leading){
                                HStack{
                                    VStack{
                                        mainViewModel.elementsIcon[currentCharacter.visionKey.lowercased()]?
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }
                                    .frame(height: 20.0)
                                    if(currentCharacter.vision != nil){
                                        Text(currentCharacter.vision)
                                            .font(.system(size: 16))
                                            .padding(.bottom,0.5)
                                    } else {
                                        Text("Unknown")
                                    }
                                }
                                if(currentCharacter.nation != nil){
                                    Text(currentCharacter.nation)
                                        .font(.system(size: 16))
                                        .padding(.bottom,0.5)
                                } else {
                                    Text("Unknown")
                                }
                                if(currentCharacter.weapon != nil){
                                    Text(currentCharacter.weapon)
                                        .font(.system(size: 16))
                                        .padding(.bottom,0.5)
                                } else {
                                    Text("Unknown")
                                }
                                if(currentCharacter.birthday != nil){
                                    Text(MyDateFormatter.birthdayDate(currentCharacter.birthday!))
                                        .font(.system(size: 16))
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
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 4)
                            
                            Text(currentCharacter.description)
                                .font(.caption)
                            if(currentCharacter.description == ""){
                                Text("No Data")
                                    .font(.caption)
                                    .padding(.vertical, 10)
                            }
                            
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 4.0)
                    
                    // MARK: - Talents
                    VStack{
                        VStack{
                            Text("Talents")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 4)
                            
                            Picker("Talents Picker", selection: $talentSelection){
                                ForEach(talentSelections, id: \.self){selection in
                                    Text(selection)
                                        .font(.system(size: 20))
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color(hue: 0.0, saturation: 0.0, brightness: 0.0, opacity: 0.3))
                            .cornerRadius(8.0)
                            
                            if(!currentCharacter.skillTalents.isEmpty){
                                switch(talentSelection){
                                case "Basic":
                                    let basic = currentCharacter.skillTalents[0]
                                    let basicSplit = basic.description.components(separatedBy: "\n")
                                    
                                    if(characterDetailViewModel.talentIcons["na"] != nil){
                                        VStack{
                                            characterDetailViewModel.talentIcons["na"]?
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        .frame(height: 38.0)
                                        .padding(.top, 12)
                                    }
                                    Text(basic.name)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.center)
                                        .padding(.vertical, 8)
                                    VStack(alignment: .leading){
                                        ForEach(basicSplit.indices, id: \.self){ index in
                                            if(index % 2 == 0){
                                                Text(basicSplit[index])
                                                    .font(.subheadline)
                                                    .fontWeight(.semibold)
                                            } else {
                                                Text(basicSplit[index])
                                                    .font(.caption)
                                                    .padding(.bottom, 10)
                                            }
                                        }
                                    }
                                    
                                case "Skill":
                                    let skill = currentCharacter.skillTalents[1]
                                    
                                    if(characterDetailViewModel.talentIcons["skill"] != nil){
                                        VStack{
                                            characterDetailViewModel.talentIcons["skill"]?
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        .frame(height: 38.0)
                                        .padding(.top, 12)
                                    }
                                    Text(skill.name)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.center)
                                        .padding(.vertical, 8)
                                    Text(skill.description)
                                        .font(.caption)
                                        .padding(.bottom, 10)
                                    
                                case "Burst":
                                    let burst = currentCharacter.skillTalents[2]
                                    
                                    if(characterDetailViewModel.talentIcons["burst"] != nil){
                                        VStack{
                                            characterDetailViewModel.talentIcons["burst"]?
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                        }
                                        .frame(height: 38.0)
                                        .padding(.top, 12)
                                    }
                                    Text(burst.name)
                                        .fontWeight(.semibold)
                                        .multilineTextAlignment(.center)
                                        .padding(.vertical, 8)
                                    Text(burst.description)
                                        .font(.caption)
                                        .padding(.bottom, 10)
                                    
                                default:
                                    Text("No Data")
                                        .font(.caption)
                                        .padding(.vertical, 10)
                                }
                                
                            } else {
                                Text("No Data")
                                    .font(.caption)
                                    .padding(.vertical, 10)
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 4.0)
                    
                    // MARK: - Passive
                    VStack{
                        VStack{
                            Text("Passive")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 4)
                            
                            if(!currentCharacter.passiveTalents.isEmpty){
                                VStack(alignment: .leading){
                                    ForEach(currentCharacter.passiveTalents.indices, id: \.self){ index in
                                        let passive = currentCharacter.passiveTalents[index]
                                        
                                        HStack(alignment: .center) {
                                            if(characterDetailViewModel.talentIcons["passive-\(index)"] != nil){
                                                VStack{
                                                    characterDetailViewModel.talentIcons["passive-\(index)"]?
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                }
                                                .frame(height: 38.0)
                                            }
                                            
                                            VStack(alignment: .leading){
                                                Text(passive.name)
                                                    .font(.subheadline)
                                                    .fontWeight(.bold)
                                                    .padding(.top, 2)
                                                Text(passive.unlock)
                                                    .font(.caption)
                                                    .fontWeight(.semibold)
                                                    .padding(.bottom, 10)
                                            }
                                        }
                                        
                                        Text(passive.description)
                                            .font(.caption)
                                            .padding(.bottom, 10)
                                        
                                    }
                                    
                                    // Sprint Passive
                                    if(currentCharacter.skillTalents.count == 4){
                                        let misc = currentCharacter.skillTalents[3]
                                        
                                        HStack(alignment: .center) {
                                            if(characterDetailViewModel.talentIcons["passive-misc"] != nil){
                                                VStack{
                                                    characterDetailViewModel.talentIcons["passive-misc"]?
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                }
                                                .frame(height: 38.0)
                                            }
                                            
                                            VStack(alignment: .leading){
                                                Text(misc.name)
                                                    .font(.subheadline)
                                                    .fontWeight(.bold)
                                                    .padding(.top, 2)
                                                Text(misc.unlock)
                                                    .font(.caption)
                                                    .fontWeight(.semibold)
                                                    .padding(.bottom, 10)
                                            }
                                        }
                                        
                                        Text(misc.description)
                                            .font(.caption)
                                            .padding(.bottom, 10)
                                    }
                                    
                                }
                            } else {
                                Text("No Data")
                                    .font(.caption)
                                    .padding(.vertical, 10)
                            }
                            
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 4.0)
                    
                    //MARK: - Constellations
                    VStack {
                        VStack{
                            Text("Constellation")
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 4)
                            HStack{
                                ForEach(1..<maximumConstellation+1, id: \.self){ number in
                                    constellationState(for: number)
                                        .onTapGesture {
                                            constellationStar = number
                                        }
                                }
                            }.padding(.vertical, 12)
                            
                            if(!currentCharacter.constellations.isEmpty){
                                
                                let cons = currentCharacter.constellations[constellationStar-1]
                                
                                VStack(alignment: .leading){
                                    HStack(alignment: .center) {
                                        VStack{
                                            if(!characterDetailViewModel.constellationIcons.isEmpty){
                                                characterDetailViewModel.constellationIcons[constellationStar]?
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                            }
                                        }
                                        .frame(height: 38.0)
                                        VStack(alignment: .leading){
                                            Text(cons.name)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .padding(.top, 2)
                                            Text(cons.unlock)
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .padding(.bottom, 10)
                                        }
                                    }
                                    Text(cons.description)
                                        .font(.caption)
                                        .padding(.bottom, 10)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text("No Data")
                                    .font(.caption)
                                    .padding(.vertical, 10)
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial)
                    .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 4.0)
                    
                }
                .padding(.horizontal, 12.0)
                .padding(.vertical, 8.0)
                .onAppear{
                    // MARK: - View Model Setup
                    characterDetailViewModel.fetch(nameId: currentNameId)
                    
                    // MARK: - Segmented Picker Settings
                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.white
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
                    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                    
                }
            }
        }
    }
}

struct CharacterDescription_Previews: PreviewProvider {
    static var mainViewModel = MainViewModel()
    
    static var previews: some View {
        CharacterDescription(currentNameId: mainViewModel.nameId.first ?? "", currentCharacter: mainViewModel.characters.first ?? Character())
            .environmentObject(mainViewModel)
    }
}

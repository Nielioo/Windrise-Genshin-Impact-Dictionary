//
//  CharacterList.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct CharacterList: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    private var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var elementFilter: ElementCategory = .all
    enum ElementCategory: String, CaseIterable, Identifiable {
        case all = "All"
        case pyro = "Pyro"
        case hydro = "Hydro"
        case anemo = "Anemo"
        case electro = "Electro"
        case dendro = "Dendro"
        case cryo = "Geo"
        
        var id: Self { self }
    }
    
    @State private var weaponFilter: WeaponCategory = .all
    enum WeaponCategory: String, CaseIterable, Identifiable {
        case all = "All"
        case sword = "Sword"
        case claymore = "Claymore"
        case polearm = "Polearm"
        case bow = "Bow"
        case catalyst = "Catalyst"
        
        var id: Self { self }
    }
    
    @State private var searchText = ""
    var filterResults: [Character] {
        if(searchText.isEmpty){
            return mainViewModel.characters.filter{(
                (elementFilter == .all || $0.visionKey.lowercased() == elementFilter.rawValue.lowercased())
                && (weaponFilter == .all || $0.weaponType.lowercased() == weaponFilter.rawValue.lowercased())
            )}
        } else {
            return mainViewModel.characters.filter{(
                $0.name.lowercased().contains(searchText.lowercased())
                && (elementFilter == .all || $0.visionKey.lowercased() == elementFilter.rawValue.lowercased())
                && (weaponFilter == .all || $0.weaponType.lowercased() == weaponFilter.rawValue.lowercased())
            )}
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack{
                MyColor.mainBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false){
                    
                    HStack(alignment: .center, spacing: 12){
                        TextField("", text: $searchText)
                            .placeholder(when: searchText.isEmpty) {
                                Text("Search Characters Here...").foregroundColor(Color(.systemGray3))
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white, lineWidth: 1.5)
                            )
                            .frame(height: 50)
                            .disableAutocorrection(false)
                        
                    }
                    .padding(.top, 10)
                    .padding(.horizontal)
                    
                    LazyVGrid(columns: columns){
                        
                        ForEach(mainViewModel.characters.indices, id: \.self){ index in
                            
                            if(!filterResults.isEmpty){
                                ForEach(filterResults){ filteredCharacter in
                                    if(mainViewModel.characters[index].name.lowercased()
                                        .contains(filteredCharacter.name.lowercased())){
                                        NavigationLink(
                                            destination:
                                                CharacterDescription(
                                                    currentNameId: mainViewModel.nameId[index],
                                                    currentCharacter: mainViewModel.characters[index]))
                                        {
                                            CharacterCard(
                                                currentNameId: mainViewModel.nameId[index],
                                                currentCharacter: mainViewModel.characters[index])
                                        }
                                        .tag(mainViewModel.characters[index].name)
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem {
                            Menu {
                                Picker("Element", selection: $elementFilter) {
                                    ForEach(ElementCategory.allCases) { element in
                                        Text(element.rawValue)
                                            .tag(element)
                                    }
                                }
                                Picker("Weapon", selection: $weaponFilter) {
                                    ForEach(WeaponCategory.allCases) { weapon in
                                        Text(weapon.rawValue)
                                            .tag(weapon)
                                    }
                                }
                            } label: {
                                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    if(filterResults.isEmpty){
                        VStack{
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                                .frame(maxWidth: .infinity, maxHeight: 75, alignment: .center)
                                .padding(.top, 40)
                                .padding(.bottom, 4)
                            Text("Ooops! There is no character named \(searchText) currently...")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                }
                .foregroundColor(.white)
            }
            .navigationTitle(/*@START_MENU_TOKEN@*/"Character List"/*@END_MENU_TOKEN@*/)
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarHidden(true)
        }
        .onAppear {
//            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = MyColor.transparentBlack
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
//            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(MainViewModel())
    }
}

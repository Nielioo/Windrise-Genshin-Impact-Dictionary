//
//  CharacterList.swift
//  Windrise
//
//  Created by MacBook Pro on 18/05/22.
//

import SwiftUI

struct CharacterList: View {
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    private var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var searchText = ""
    var searchResults: [Character] {
        if(searchText.isEmpty){
            return mainViewModel.characters
        }else{
            return mainViewModel.characters.filter{
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            ZStack{
                MyColor.mainBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false){
                    
                    TextField("Search Characters", text: $searchText)
                        .foregroundColor(.white)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white, lineWidth: 1.5)
                        )
                        .frame(height: 50)
                        .padding(.horizontal)
                        .padding(.top, 40)
                        .disableAutocorrection(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
                    
                    LazyVGrid(columns: columns){
                        
                        ForEach(mainViewModel.characters.indices, id: \.self){ index in
                            
                            if(!searchResults.isEmpty){
                                
                                ForEach(searchResults){ filteredCharacter in
                                    
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
                                
                            } else {
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
                    .padding()
                }
                .foregroundColor(.white)
            }
//            .navigationTitle(/*@START_MENU_TOKEN@*/"Character List"/*@END_MENU_TOKEN@*/)
            .navigationBarHidden(true)
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
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

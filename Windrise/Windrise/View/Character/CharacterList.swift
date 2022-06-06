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
                    
                    HStack(alignment: .center){
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
                            .padding(.horizontal)
                            .padding(.top, 40)
                            .disableAutocorrection(false)
                    }
                    
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
                            }
                            
                        }
                    }
                    .padding()
                    
                    if(searchResults.isEmpty){
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

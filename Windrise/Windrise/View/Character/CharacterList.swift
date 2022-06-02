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
    
    var body: some View {
        
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("BackgroundDarkBlue"), Color("BackgroundDarkPurple")]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: columns){
                        ForEach(mainViewModel.characters.indices, id: \.self){ index in
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
                    .padding()
                }
                .foregroundColor(.white)
            }
            .navigationTitle(/*@START_MENU_TOKEN@*/"Character List"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
            .environmentObject(MainViewModel())
    }
}

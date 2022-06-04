//
//  Profile.swift
//  Windrise
//
//  Created by MacBook Pro on 02/06/22.
//

import SwiftUI

struct Profile: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.nameId)],
        predicate: NSPredicate(format: "isOwned = true"))
    private var ownedCharacters: FetchedResults<OwnedCharacter>
    
    @EnvironmentObject var mainViewModel: MainViewModel
    
    private var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView{
            ZStack{
                MyColor.mainBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false){
                    
                    // MARK: - Favorite Characters
                    VStack(alignment: .leading, spacing: 10){
                        Text("Owned Characters")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if(ownedCharacters.isEmpty){
                            
                            Image(systemName: "exclamationmark.triangle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                                .padding(.top, 20)
                                .padding(.bottom, 4)
                            Text("Ooops! You didn\'t own any character currently...")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Text("\n\nTips: You can add a character by clicking checkmark icon on the top of character detail page")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.gray)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                                   
                        } else {
                            
                            LazyVGrid(columns: columns){
                                ForEach(ownedCharacters, id: \.self){ character in
                                    if let index = mainViewModel.nameId.firstIndex(of: character.nameId ?? "0"){
                                        NavigationLink(destination: CharacterDescription(
                                            currentNameId: mainViewModel.nameId[index],
                                            currentCharacter: mainViewModel.characters[index])){
                                                CharacterCard(
                                                    currentNameId: mainViewModel.nameId[index],
                                                    currentCharacter: mainViewModel.characters[index])
                                            }
                                            .tag(mainViewModel.nameId[index])
                                            .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                            
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(MainViewModel())
    }
}

//
//  Home.swift
//  Windrise
//
//  Created by MacBook Pro on 02/06/22.
//

import SwiftUI

struct Home: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.nameId)],
        predicate: NSPredicate(format: "isFavorite = true"))
    private var favoriteCharacters: FetchedResults<FavoriteCharacter>
    
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    private var columns : [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ZStack {
                MyColor.mainBackground.ignoresSafeArea()
                
                ScrollView (showsIndicators: false){
                    VStack{
                        // MARK: - Current Banner
                        VStack(alignment: .leading){
                            Text("Current Banners")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                
                            PageView(pages: homeViewModel.bannerImages.map { FeaturedCard(banner: $0) })
                                .aspectRatio(2.03/1, contentMode: .fill)
                                .cornerRadius(12)
                        }
                        .padding(.vertical, 10)
                        
                        // MARK: - Favorite Characters
                        VStack(alignment: .leading, spacing: 10){
                            Text("Favorite Characters")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            if(favoriteCharacters.isEmpty){
                                
                                Image(systemName: "exclamationmark.triangle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.gray)
                                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                                    .padding(.top, 20)
                                    .padding(.bottom, 4)
                                Text("Ooops! There is no favorable character currently...")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                Text("\n\nTips: You can favorite a character by clicking heart icon on the top of character detail page")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                       
                            } else {
                                
                                LazyVGrid(columns: columns){
                                    ForEach(favoriteCharacters, id: \.self){ character in
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
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        
                    }
                    .padding()
                }
                .navigationTitle("Home")
//                .navigationBarHidden(true)
            }
            
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(MainViewModel())
    }
}

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
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        Text("Profile!")
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}

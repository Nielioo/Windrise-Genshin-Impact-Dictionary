//
//  FavoriteButton.swift
//  Windrise
//
//  Created by MacBook Pro on 02/06/22.
//

import SwiftUI
import CoreData

struct FavoriteButton: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var nameId: String
    @State var page: Page
    @Binding var isSet: Bool
    
    enum Page {
        case character
    }
    
    var body: some View {
        Button {
            isSet.toggle()
            
            switch (page) {
            case .character:
                let fetchFavoriteCharacters: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
                fetchFavoriteCharacters.predicate = NSPredicate(format: "nameId = %@", nameId)
                
                let results = try? moc.fetch(fetchFavoriteCharacters)
                
                if results?.count == 0 {
                    // New data
                    let favoriteCharacter = FavoriteCharacter(context: moc)
                    favoriteCharacter.nameId = nameId
                    favoriteCharacter.isFavorite = isSet
                } else {
                    // Data exists
                    let favoriteCharacter = results?.first
                    favoriteCharacter?.nameId = nameId
                    favoriteCharacter?.isFavorite = isSet
                }
            }
            
            try? moc.save()
        } label: {
            if isSet {
                ButtonFavoriteActive()
            } else {
                ButtonFavoriteInactive()
            }
        }
    }
}

struct ButtonFavoriteActive: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(MyColor.favoriteActiveBackground)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 40)
            
            Image(systemName: "heart.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .offset(y: 1)
        }
    }
}

struct ButtonFavoriteInactive: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThickMaterial)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 40)
            
            Image(systemName: "heart.fill")
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .offset(y: 1)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(nameId: "albedo", page: .character, isSet: .constant(true))
    }
}

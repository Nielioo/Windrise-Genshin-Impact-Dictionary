//
//  OwnedButton.swift
//  Windrise
//
//  Created by MacBook Pro on 02/06/22.
//

import SwiftUI
import CoreData

struct OwnedButton: View {
    
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
                let fetchOwnedCharacters: NSFetchRequest<OwnedCharacter> = OwnedCharacter.fetchRequest()
                fetchOwnedCharacters.predicate = NSPredicate(format: "nameId = %@", nameId)
                
                let results = try? moc.fetch(fetchOwnedCharacters)
                
                if results?.count == 0 {
                    // New data
                    let ownedCharacter = OwnedCharacter(context: moc)
                    ownedCharacter.nameId = nameId
                    ownedCharacter.isOwned = isSet
                } else {
                    // Data exists
                    let favoriteCharacter = results?.first
                    favoriteCharacter?.nameId = nameId
                    favoriteCharacter?.isOwned = isSet
                }
            }
            
            try? moc.save()
        } label: {
            if isSet {
                ButtonOwnedActive()
            } else {
                ButtonOwnedInactive()
            }
        }
    
    }
}

struct ButtonOwnedActive: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(MyColor.ownedActiveBackground)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 40)
            
            Image(systemName: "checkmark")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .offset(y: 1)
        }
    }
}

struct ButtonOwnedInactive: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThickMaterial)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 40)
            
            Image(systemName: "checkmark")
                .font(.system(size: 20))
                .foregroundColor(.gray)
                .offset(y: 1)
        }
    }
}

struct OwnedButton_Previews: PreviewProvider {
    static var previews: some View {
        OwnedButton(nameId: "albedo", page: .character, isSet: .constant(false))
            .environment(\.managedObjectContext, DataController().container.viewContext)
    }
}

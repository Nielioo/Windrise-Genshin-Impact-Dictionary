//
//  ProfileViewModel.swift
//  Windrise
//
//  Created by MacBook Pro on 04/06/22.
//

import Foundation
import SwiftUI
import CoreData

class ProfileViewModel: ObservableObject{
    @Published var userModel: UserModel = UserModel.default
    
    func fetch(moc: NSManagedObjectContext){
        // MARK: Get username
        let fetchUserInfoData: NSFetchRequest<UserInfoData> = UserInfoData.fetchRequest()
        fetchUserInfoData.predicate = NSPredicate()

        if let results = try? moc.fetch(fetchUserInfoData) {
            if results.count != 0 {
                if let userInfoData = results.first {
                    self.userModel.username = userInfoData.username!
                }
            }
        }
    }
}

//
//  UserInfo.swift
//  Windrise
//
//  Created by MacBook Pro on 04/06/22.
//

import Foundation
import SwiftUI

struct UserModel{
    var username: String
    var profilePicture: Image
    
    static let `default` = UserModel(username: "Nielio", profilePicture: Image("DefaultProfilePicture"))
    
}

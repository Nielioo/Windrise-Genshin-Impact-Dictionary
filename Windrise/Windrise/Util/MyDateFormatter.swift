//
//  DateFormatter.swift
//  Windrise
//
//  Created by MacBook Pro on 28/05/22.
//

import Foundation
import SwiftUI

struct MyDateFormatter{
    static func birthdayDate(_ rawDate: String) -> String{
        let DEFAULT_YEAR: String = "2000"
        
        let rawDate = rawDate.replacingOccurrences(of: "0000", with: DEFAULT_YEAR)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let tmpDate = dateFormatter.date(from: rawDate) else { return rawDate}
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "dd MMMM"
        
        let finalDate = dateFormatter2.string(from: tmpDate)
        return finalDate
    }
}

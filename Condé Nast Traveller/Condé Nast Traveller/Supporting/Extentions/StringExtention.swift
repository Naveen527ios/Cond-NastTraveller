//
//  StringExtention.swift
//  Condé Nast Traveller
//
//  Created by Naveen Kumar on 20/03/25.
//

import Foundation

extension String {
    
    func convertStringIntoDate() -> String{
        
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: self) {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d 'at' h:mm a"
            let formattedDate = formatter.string(from: date)
            return "\(formattedDate)"
        }
        return ""
    }
}

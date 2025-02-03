//
//  Helpers.swift
//  Scrum Helper
//
//  Created by Mykyta Shemechko on 03/02/2025.
//


import Foundation

class Helper {
    
    static func formatDate(_ dateString: String, format: String = "yyyy-MM-dd") -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return "Invalid date"
    }
    
    static func convertToDate(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: dateString)
    }
}



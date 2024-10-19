//
//  JournalDateFormatter.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import Foundation

struct JournalDateFormatter {
    static let shared = JournalDateFormatter()
    
    private let dateFormatter: DateFormatter
    private let timeFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, EEEE"
        
        timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
    }
    
    func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func formatTime(_ date: Date) -> String {
        return timeFormatter.string(from: date)
    }
}

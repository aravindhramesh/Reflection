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
    private let searchDateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, EEEE"
        
        timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        
        searchDateFormatter = DateFormatter()
        searchDateFormatter.dateFormat = "d MMM yyyy"
    }
    
    func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func formatTime(_ date: Date) -> String {
        return timeFormatter.string(from: date)
    }
    
    func parseSearchDate(_ dateString: String) -> Date? {
        return searchDateFormatter.date(from: dateString)
    }
}

//
//  EntryRowView.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import SwiftUI
import CoreData

struct EntryRowView: View {
    let entry: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(JournalDateFormatter.shared.formatDate(entry.date ?? Date()))
                .font(.headline)
            Text(entry.content ?? "")
                .lineLimit(2)
                .font(.subheadline)
        }
    }
}

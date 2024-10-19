//
//  EntryDetailView.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import SwiftUI
import CoreData

struct EntryDetailView: View {
    let entry: JournalEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(JournalDateFormatter.shared.formatDate(entry.date ?? Date()))
                    Spacer()
                    Text(JournalDateFormatter.shared.formatTime(entry.date ?? Date()))
                }
                .font(.headline)
                
                Text(entry.content ?? "")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(JournalDateFormatter.shared.formatDate(entry.date ?? Date()))
        .navigationBarTitleDisplayMode(.inline)
    }
}

//
//  EntryRowView.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//
import SwiftUI

struct EntryRowView: View {
    let entry: JournalEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(formatTime(entry.date ?? Date()))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
                Text(entry.content ?? "")
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                    .lineLimit(2)
            }
            Spacer()
//            Image(systemName: "chevron.right")
//                .foregroundColor(.secondary)
        }
//        .padding(16)
//        .background(Color(UIColor.systemGray6))
//        .cornerRadius(12)
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date).uppercased()
    }
}

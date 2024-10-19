//
//  SearchView.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import SwiftUI
import CoreData

struct SearchView: View {
    @ObservedObject var dataManager: JournalDataManager
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode

    var filteredEntries: [JournalEntry] {
        if searchText.isEmpty {
            return dataManager.entries
        } else {
            return dataManager.entries.filter { $0.content?.lowercased().contains(searchText.lowercased()) ?? false }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredEntries) { entry in
                NavigationLink(destination: EntryDetailView(entry: entry)) {
                    EntryRowView(entry: entry)
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search entries")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

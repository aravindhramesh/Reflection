//
//  ContentView.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var dataManager: JournalDataManager
    @State private var isNewEntryViewPresented = false
    @State private var searchText = ""

    init(context: NSManagedObjectContext) {
        _dataManager = StateObject(wrappedValue: JournalDataManager(context: context))
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    searchBar
                    
                    List {
                        ForEach(groupedEntries, id: \.0) { date, entries in
                            Section(header: DateHeaderView(date: date)) {
                                ForEach(entries) { entry in
                                    NavigationLink(destination: EntryDetailView(entry: entry)) {
                                        EntryRowView(entry: entry)
                                    }
                                    .listRowBackground(Color(red: 28/255, green: 28/255, blue: 30/255))
                                    .padding(8)
                                    .cornerRadius(20)
//                                    .listRowSeparator(.fill)
                                }
                              
                        
                            }
                        }
                    }
//                    .listStyle(PlainListStyle())
                    .environment(\.defaultMinListRowHeight, 10)
                    
                }
            }
            .navigationTitle("Reflections")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        isNewEntryViewPresented = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .frame(width: 60, height: 60)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            
                    }
                }
            }
//            .toolbarBackground(.hidden, for: .navigationBar)
            .sheet(isPresented: $isNewEntryViewPresented) {
                NewEntryView(dataManager: dataManager)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search", text: $searchText)
                .foregroundColor(.primary)
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    private var groupedEntries: [(Date, [JournalEntry])] {
            let filteredEntries = dataManager.entries.filter { entry in
                if searchText.isEmpty {
                    return true
                }
                
                let contentMatch = entry.content?.localizedCaseInsensitiveContains(searchText) ?? false
                let dateMatch = isDateMatch(entry: entry, searchText: searchText)
                
                return contentMatch || dateMatch
            }
            
            let grouped = Dictionary(grouping: filteredEntries) { entry in
                Calendar.current.startOfDay(for: entry.date ?? Date())
            }
            
            return grouped.sorted { $0.key > $1.key }
        }
        
        private func isDateMatch(entry: JournalEntry, searchText: String) -> Bool {
            guard let entryDate = entry.date else { return false }
            
            // Check if the search text matches the formatted date
            let formattedDate = JournalDateFormatter.shared.formatDate(entryDate)
            if formattedDate.localizedCaseInsensitiveContains(searchText) {
                return true
            }
            
            // Check if the search text is a valid date and matches the entry date
            if let searchDate = JournalDateFormatter.shared.parseSearchDate(searchText) {
                let calendar = Calendar.current
                return calendar.isDate(entryDate, inSameDayAs: searchDate)
            }
            
            return false
        }
    
}


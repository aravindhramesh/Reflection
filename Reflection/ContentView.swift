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
                
                VStack {
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
                                }
                              
                        
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
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
            searchText.isEmpty || entry.content?.localizedCaseInsensitiveContains(searchText) == true
        }
        
        let grouped = Dictionary(grouping: filteredEntries) { entry in
            Calendar.current.startOfDay(for: entry.date ?? Date())
        }
        
        return grouped.sorted { $0.key > $1.key }
    }
}


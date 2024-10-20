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
    @State private var isSearchViewPresented = false

    init() {
        let context = PersistenceController.shared.container.viewContext
        _dataManager = StateObject(wrappedValue: JournalDataManager(context: context))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(dataManager.entries) { entry in
                    NavigationLink(destination: EntryDetailView(entry: entry)) {
                        EntryRowView(entry: entry)
                    }
                }
                .onDelete(perform: dataManager.deleteEntry)
            }
            .navigationTitle("Reflections")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isSearchViewPresented = true
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
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
            .sheet(isPresented: $isSearchViewPresented) {
                SearchView(dataManager: dataManager)
            }
        }
    }
}

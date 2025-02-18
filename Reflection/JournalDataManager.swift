//
//  JournalDataManager.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//
import Foundation
import CoreData

class JournalDataManager: ObservableObject {
    @Published var entries: [JournalEntry] = []
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchEntries()
    }
    
    func fetchEntries() {
        let request: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \JournalEntry.date, ascending: false)]
        
        do {
            entries = try context.fetch(request)
        } catch {
            print("Error fetching entries: \(error)")
        }
    }
    
    func addEntry(content: String) {
        let newEntry = JournalEntry.create(in: context, content: content)
        entries.insert(newEntry, at: 0)
        saveContext()
    }
    
    func deleteEntry(at offsets: IndexSet) {
        offsets.map { entries[$0] }.forEach(context.delete)
        entries.remove(atOffsets: offsets)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

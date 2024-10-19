//
//  JournalEntry.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import Foundation
import CoreData

@objc(JournalEntry)
public class JournalEntry: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var content: String?

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntry> {
        return NSFetchRequest<JournalEntry>(entityName: "JournalEntry")
    }

    static func create(in context: NSManagedObjectContext, content: String) -> JournalEntry {
        let entry = JournalEntry(context: context)
        entry.id = UUID()
        entry.date = Date()
        entry.content = content
        return entry
    }
}

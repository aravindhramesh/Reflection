//
//  ReflectionApp.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import SwiftUI

@main
struct JournalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

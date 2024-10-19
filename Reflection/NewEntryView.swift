//
//  NewEntryView.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import SwiftUI
import CoreData

struct NewEntryView: View {
    @ObservedObject var dataManager: JournalDataManager
    @State private var entryContent = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(JournalDateFormatter.shared.formatDate(Date()))
                    Spacer()
                    Text(JournalDateFormatter.shared.formatTime(Date()))
                }
                .padding()
                
                TextEditor(text: $entryContent)
                    .padding()
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dataManager.addEntry(content: entryContent)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(entryContent.isEmpty)
                }
            }
        }
    }
}

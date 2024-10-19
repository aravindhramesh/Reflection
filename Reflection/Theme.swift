//
//  Theme.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import SwiftUI

struct JournalTheme {
    static let backgroundColor = Color.black
    static let secondaryBackgroundColor = Color(red: 28/255, green: 28/255, blue: 30/255)
    static let textColor = Color.white
    static let accentColor = Color.blue
}

struct JournalAppearanceModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(.dark)
            .accentColor(JournalTheme.accentColor)
            .foregroundColor(JournalTheme.textColor)
    }
}

extension View {
    func journalAppearance() -> some View {
        self.modifier(JournalAppearanceModifier())
    }
}


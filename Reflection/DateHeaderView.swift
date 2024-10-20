//
//  DateHeaderView.swift
//  Reflection
//
//  Created by Aravindh Ramesh on 19/10/2024.
//

import SwiftUI

struct DateHeaderView: View {
    let date: Date
    
    var body: some View {
        Text(JournalDateFormatter.shared.formatDate(date))
            .font(.headline)
            .foregroundColor(.primary)
            .padding(.top, 20)
            .padding(.bottom, 10)
    }
}

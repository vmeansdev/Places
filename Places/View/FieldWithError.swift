//
//  FieldWithError.swift
//  Places
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
import SwiftUI

struct FieldWithError: View {
    let title: String
    @Binding var text: String
    @Binding var showError: Bool

    var body: some View {
        VStack(alignment: .leading) {
            TextField(title, text: $text)
                .keyboardType(.decimalPad)
                .border(showError && text.isEmpty ? Color.red : Color.clear, width: 1)
            if showError && text.isEmpty {
                Text(Constants.requiredText)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }

    private enum Constants {
        static let requiredText = "This field is required"
    }
}

#Preview {
    FieldWithError(
        title: "Field",
        text: .constant("Some text"),
        showError: .constant(false)
    )
}

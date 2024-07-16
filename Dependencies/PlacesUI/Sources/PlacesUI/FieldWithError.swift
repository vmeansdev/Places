//
//  FieldWithError.swift
//  Places
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
import SwiftUI

public struct FieldWithError: View {
    let title: String
    let errorText: String
    @Binding var text: String
    @Binding var showError: Bool

    public init(title: String, errorText: String, text: Binding<String>, showError: Binding<Bool>) {
        self.title = title
        self.errorText = errorText
        self._text = text
        self._showError = showError
    }

    public var body: some View {
        VStack(alignment: .leading) {
            TextField(title, text: $text)
                .keyboardType(.decimalPad)
            if showError {
                Text(errorText)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    FieldWithError(
        title: "Field",
        errorText: "This field is required",
        text: .constant("Some text"),
        showError: .constant(false)
    )
}

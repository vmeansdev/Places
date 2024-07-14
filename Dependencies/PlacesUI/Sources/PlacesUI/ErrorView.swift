//
//  ErrorView.swift
//
//
//  Created by Nikita Kononenko on 30.05.2024.
//

import SwiftUI

public struct ErrorView: View {
    public let errorMessage: String
    public let actionButtonText: String
    public let actionButtonAction: () -> Void
    public let errorTitle: String

    public init(errorMessage: String, actionButtonText: String, actionButtonAction: @escaping () -> Void, errorTitle: String = "Error") {
        self.errorMessage = errorMessage
        self.actionButtonText = actionButtonText
        self.actionButtonAction = actionButtonAction
        self.errorTitle = errorTitle
    }

    public var body: some View {
        VStack {
            Text(errorTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 10)
                .accessibilityLabel(errorTitle)
                .accessibilityValue(errorTitle)

            Text(errorMessage)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
                .accessibilityLabel(errorTitle)
                .accessibilityValue(errorMessage)

            Button(action: actionButtonAction) {
                Text(actionButtonText)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .accessibilityLabel(actionButtonText)
                    .accessibilityValue(actionButtonText)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
    }
}

#Preview {
    ErrorView(
        errorMessage: "Something went wrong",
        actionButtonText: "Retry",
        actionButtonAction: {},
        errorTitle: "Error"
    )
}


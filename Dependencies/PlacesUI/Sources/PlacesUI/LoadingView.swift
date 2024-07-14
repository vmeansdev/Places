//
//  LoadingView.swift
//
//
//  Created by Nikita Kononenko on 30.05.2024.
//

import SwiftUI

public struct LoadingView: View {
    @State private var isAnimating = false
    private var message: String?
    private var progressMessage: String?

    public init(message: String? = "Loading...", progressMessage: String? = nil) {
        self.message = message
        self.progressMessage = progressMessage
    }

    public var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)

            VStack(spacing: 16) {
                Circle()
                    .trim(from: 0.0, to: 0.7)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .frame(width: 80, height: 80)
                    .onAppear {
                        withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                            self.isAnimating = true
                        }
                    }

                if let message = message {
                    Text(message)
                        .font(.system(size: 18, weight: .semibold))
                }

                if let progressMessage = progressMessage {
                    Text(progressMessage)
                        .font(.system(size: 14, weight: .thin))
                }
            }
        }
    }
}

#Preview {
    LoadingView(message: "Loading", progressMessage: "50% completed")
}


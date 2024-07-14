//
//  OpenLocationView.swift
//  Places
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
import PlacesData
import PlacesUI
import SwiftUI

struct OpenLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var shouldDisplayError = false

    var onSave: (Location) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField(Constants.nameText, text: $name)
                    FieldWithError(title: Constants.latitudeText, text: $latitude, showError: $shouldDisplayError)
                    FieldWithError(title: Constants.longitudeText, text: $longitude, showError: $shouldDisplayError)
                }
                Button(action: handleSave) {
                    Text(Constants.openText)
                }
            }
            .navigationTitle(Constants.addPlaceText)
            .toolbar(content: {
                Button(Constants.cancelText) {
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }

    private func handleSave() {
        guard !latitude.isEmpty, !longitude.isEmpty else {
            shouldDisplayError = true
            return
        }
        onSave(
            Location(
                name: name.isEmpty ? nil : name,
                latitude: Double(latitude) ?? 0,
                longitude: Double(longitude) ?? 0
            )
        )
        presentationMode.wrappedValue.dismiss()
    }

    private enum Constants {
        static let nameText = "Name"
        static let latitudeText = "Latitude"
        static let longitudeText = "Longitude"
        static let openText = "Open"
        static let addPlaceText = "Open a new place"
        static let cancelText = "Cancel"
    }
}

#Preview {
    OpenLocationView(onSave: { _ in })
}

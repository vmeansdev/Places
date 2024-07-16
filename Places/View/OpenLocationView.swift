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

    var onOpen: (Location) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField(Constants.nameText, text: $name)
                        .accessibilityLabel(Constants.nameFieldLabel)
                        .accessibilityHint(Constants.nameFieldHint)
                    FieldWithError(
                        title: Constants.latitudeText,
                        errorText: Constants.invalidLatitudeText,
                        text: $latitude,
                        showError: $shouldDisplayError
                    )
                        .accessibilityLabel(Constants.latitudeLabel)
                        .accessibilityHint(Constants.latitudeFieldHint)
                    FieldWithError(
                        title: Constants.longitudeText,
                        errorText: Constants.invalidLongitudeText,
                        text: $longitude,
                        showError: $shouldDisplayError
                    )
                        .accessibilityLabel(Constants.longitudeLabel)
                        .accessibilityHint(Constants.longitudeFieldHint)
                }
                Button(action: handleSave) {
                    Text(Constants.openText)
                }
                .accessibilityLabel(Constants.openText)
                .accessibilityHint(Constants.openHint)
            }
            .navigationTitle(Constants.openPlaceText)
            .accessibilityElement(children: .contain)
            .toolbar(content: {
                Button(Constants.cancelText) {
                    presentationMode.wrappedValue.dismiss()
                }
                .accessibilityLabel(Constants.cancelText)
                .accessibilityHint(Constants.cancelHint)
            })
        }
    }

    private func handleSave() {
        guard CoordinatesInputValidator.isValidLatitude(latitude), CoordinatesInputValidator.isValidLongitude(longitude) else {
            shouldDisplayError = true
            return
        }
        onOpen(
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
        static let nameFieldLabel = "Name text field"
        static let nameFieldHint = "Enter the name of the location"
        static let latitudeText = "Latitude"
        static let latitudeLabel = "Latitude text field"
        static let latitudeFieldHint = "Enter the latitude of the location. This field is required"
        static let longitudeText = "Longitude"
        static let longitudeLabel = "Longitude text field"
        static let longitudeFieldHint = "Enter the longitude of the location. This field is required"
        static let openText = "Open"
        static let openHint = "Tap to open the location in Wikipedia app"
        static let openPlaceText = "Open a new place"
        static let cancelText = "Cancel"
        static let cancelHint = "Tap to cancel and go back to the previous screen"
        static let invalidLatitudeText = "Invalid latitude! Please enter a value in a range from -90 to 90"
        static let invalidLongitudeText = "Invalid longitude! Please enter a value in a range from -180 to 180"
    }
}

#Preview {
    OpenLocationView(onOpen: { _ in })
}

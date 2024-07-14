//
//  DependencyProvider.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import Foundation
import UIKit

final class DependenciesProvider: ObservableObject {
    func makeLocationsService() -> LocationsServiceProtocol {
        guard let url = URL(string: Constants.locationsURLString) else {
            fatalError("locationsURLString is not a valid URL")
        }
        return LocationsService(locationsURL: url)
    }

    func makeDeeplinkService() -> DeeplinkServiceProtocol {
        DeeplinkService(deeplinkOpener: UIApplication.shared)
    }

    func makeLocationsViewModel() -> LocationsViewModel {
        .init(locationsService: makeLocationsService(), deeplinkService: makeDeeplinkService())
    }

    private enum Constants {
        static let locationsURLString = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
    }
}

//
//  DependencyProvider.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import Foundation
import PlacesData
import PlistReader
import UIKit

final class DependenciesProvider {
    private(set) lazy var plistReader: PlistReader = {
        .init(bundle: Bundle.main)
    }()

    func makeLocationsService() -> LocationsServiceProtocol {
        guard let url = URL(string: try! plistReader.value(for: Constants.locationsURLKey)) else {
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
        static let locationsURLKey = "PLACES_URL"
    }
}

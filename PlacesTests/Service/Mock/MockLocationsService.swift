//
//  MockLocationsService.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
@testable import Places

final class MockLocationsService: LocationsServiceProtocol {
    var fetchLocationsResult: Result<[Location], Error>?

    func fetchLocations() async throws -> [Location] {
        switch fetchLocationsResult {
        case .success(let locations):
            return locations
        case .failure(let error):
            throw error
        case .none:
            fatalError("fetchLocationsResult not set")
        }
    }
}

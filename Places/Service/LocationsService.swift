//
//  LocationsService.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import Foundation

protocol LocationsServiceProtocol {
    func fetchLocations() async throws -> [Location]
}

final class LocationsService: LocationsServiceProtocol {
    private let locationsURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    init(locationsURL: URL, session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.locationsURL = locationsURL
        self.session = session
        self.decoder = decoder
    }

    func fetchLocations() async throws -> [Location] {
        let (data, _) = try await session.data(from: locationsURL)
        return try decoder.decode(LocationsResponse.self, from: data).locations
    }
}

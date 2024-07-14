//
//  LocationsService.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import Foundation

public protocol LocationsServiceProtocol {
    func fetchLocations() async throws -> [Location]
}

public final class LocationsService: LocationsServiceProtocol {
    private let locationsURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(locationsURL: URL, session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.locationsURL = locationsURL
        self.session = session
        self.decoder = decoder
    }

    public func fetchLocations() async throws -> [Location] {
        let (data, _) = try await session.data(from: locationsURL)
        return try decoder.decode(LocationsResponse.self, from: data).locations
    }
}

//
//  LocationsServiceTests.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
import XCTest
@testable import Places

final class LocationsServiceTests: XCTestCase {
    private var service: LocationsServiceProtocol!

    override func setUp() {
        super.setUp()
        URLProtocol.registerClass(MockURLProtocol.self)
    }

    override func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        super.tearDown()
    }

    func testFetchValidLocationsSuccess() async throws {
        service = LocationsService(locationsURL: URL(string: Constants.validJSONURL)!)
        let locations = try await service.fetchLocations()
        XCTAssertEqual(locations.count, 4)
    }

    func testFetchLocationsFailsWhenNullabilityIsInvalid() async throws {
        service = LocationsService(locationsURL: URL(string: Constants.invalidNullabilityJSONURL)!)
        do {
            _ = try await service.fetchLocations()
        } catch {
            XCTAssertTrue(true)
        }
    }

    private enum Constants {
        static let validJSONURL = "http://localhost/valid.json"
        static let invalidNullabilityJSONURL = "http://localhost/invalid_nullability.json"
    }
}

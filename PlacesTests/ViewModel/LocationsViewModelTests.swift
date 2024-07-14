//
//  LocationsViewModelTests.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
import XCTest
@testable import Places

final class LocationsViewModelTests: XCTestCase {
    var viewModel: LocationsViewModel!
    var mockLocationsService: MockLocationsService!
    var mockDeeplinkService: MockDeeplinkService!

    private enum TestsError: Error {
        case loadLocations

        var localizedDescription: String {
            Constants.loadLocations
        }
    }

    override func setUp() {
        super.setUp()
        mockLocationsService = MockLocationsService()
        mockDeeplinkService = MockDeeplinkService()
        viewModel = LocationsViewModel(locationsService: mockLocationsService, deeplinkService: mockDeeplinkService)
    }

    override func tearDown() {
        viewModel = nil
        mockLocationsService = nil
        mockDeeplinkService = nil
        super.tearDown()
    }

    func testLoadLocations_success() {
        // Given
        let locations = [Constants.testLocation]
        mockLocationsService.fetchLocationsResult = .success(locations)
        let expectation = XCTestExpectation(description: Constants.loadLocationsExpectation)
        // When
        viewModel.loadLocations()
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            expectation.fulfill()
            XCTAssertEqual(self?.viewModel.state, .loaded(locations))
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadLocations_failure() {
        // Given
        mockLocationsService.fetchLocationsResult = .failure(TestsError.loadLocations)
        // When
        viewModel.loadLocations()
        // Then
        if case let .error(message) = viewModel.state {
            XCTAssertEqual(message, Constants.loadLocations)
        }
    }

    func testCancelLoading() {
        // Given
        let expectation = XCTestExpectation(description: Constants.cancelLoadingExpectation)
        mockLocationsService.fetchLocationsResult = .failure(TestsError.loadLocations)
        // When
        viewModel.loadLocations()
        viewModel.cancelLoading()
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertNil(self.viewModel.cancellationToken)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testOpenWiki() {
        // Given
        let location = Constants.testLocation
        // When
        viewModel.openWiki(location: location)
        // Then
        XCTAssertEqual(mockDeeplinkService.openedLocation, location)
    }

    private enum Constants {
        static let testLocation = Location(name: "San Francisco", latitude: 37.7749, longitude: -122.4194)
        static let loadLocations = "loadLocations"
        static let loadLocationsExpectation = "Load locations"
        static let cancelLoadingExpectation = "Cancel loading"
    }
}

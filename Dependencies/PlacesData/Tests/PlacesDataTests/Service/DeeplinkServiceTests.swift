//
//  DeeplinkServiceTests.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
import XCTest
@testable import PlacesData
@testable import PlacesDataMocks

final class DeeplinkServiceTests: XCTestCase {
    var mockDeeplinkOpener: MockDeeplinkOpener!
    var deeplinkService: DeeplinkService!

    override func setUp() {
        super.setUp()
        mockDeeplinkOpener = MockDeeplinkOpener()
        deeplinkService = DeeplinkService(deeplinkOpener: mockDeeplinkOpener)
    }

    override func tearDown() {
        mockDeeplinkOpener = nil
        deeplinkService = nil
        super.tearDown()
    }

    func testOpenWiki_withValidLocation() {
        // Given
        let location = Location(name: "San Francisco", latitude: 37.7749, longitude: -122.4194)

        // When
        deeplinkService.openWiki(location: location)

        // Then
        let expectedURLString = "wikipedia://places?lat=37.7749&long=-122.4194&place_name=San%20Francisco"
        XCTAssertEqual(mockDeeplinkOpener.lastOpenedURL?.absoluteString, expectedURLString)
    }

    func testOpenWiki_withLocationWithoutName() {
        // Given
        let location = Location(name: nil, latitude: 37.7749, longitude: -122.4194)

        // When
        deeplinkService.openWiki(location: location)

        // Then
        let expectedURLString = "wikipedia://places?lat=37.7749&long=-122.4194"
        XCTAssertEqual(mockDeeplinkOpener.lastOpenedURL?.absoluteString, expectedURLString)
    }
}

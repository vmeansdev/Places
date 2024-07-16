//
//  CoordinatesValidatorTests.swift
//
//
//  Created by Nikita Kononenko on 16.07.2024.
//

import Foundation
import XCTest
@testable import PlacesData

class CoordinatesInputValidatorTests: XCTestCase {
    func testValidLatitudes() {
        XCTAssertTrue(CoordinatesInputValidator.isValidLatitude("0"), "Latitude 0 should be valid")
        XCTAssertTrue(CoordinatesInputValidator.isValidLatitude("45.0"), "Latitude 45.0 should be valid")
        XCTAssertTrue(CoordinatesInputValidator.isValidLatitude("90"), "Latitude 90 should be valid")
        XCTAssertTrue(CoordinatesInputValidator.isValidLatitude("-90"), "Latitude -90 should be valid")
        XCTAssertTrue(CoordinatesInputValidator.isValidLatitude("89.999"), "Latitude 89.999 should be valid")
    }

    func testInvalidLatitudes() {
        XCTAssertFalse(CoordinatesInputValidator.isValidLatitude("91"), "Latitude 91 should be invalid")
        XCTAssertFalse(CoordinatesInputValidator.isValidLatitude("-91"), "Latitude -91 should be invalid")
        XCTAssertFalse(CoordinatesInputValidator.isValidLatitude("100"), "Latitude 100 should be invalid")
        XCTAssertFalse(CoordinatesInputValidator.isValidLatitude("90.1"), "Latitude 90.1 should be invalid")
        XCTAssertFalse(CoordinatesInputValidator.isValidLatitude("abc"), "Latitude 'abc' should be invalid")
    }

    func testValidLongitudes() {
        XCTAssertTrue(CoordinatesInputValidator.isValidLongitude("0"), "Longitude 0 should be valid")
        XCTAssertTrue(CoordinatesInputValidator.isValidLongitude("45.0"), "Longitude 45.0 should be valid")
        XCTAssertTrue(CoordinatesInputValidator.isValidLongitude("180"), "Longitude 180 should be valid")
        XCTAssertTrue(CoordinatesInputValidator.isValidLongitude("-180"), "Longitude -180 should be valid")
        XCTAssertTrue(CoordinatesInputValidator.isValidLongitude("179.999"), "Longitude 179.999 should be valid")
    }

    func testInvalidLongitudes() {
        XCTAssertFalse(CoordinatesInputValidator.isValidLongitude("181"), "Longitude 181 should be invalid")
        XCTAssertFalse(CoordinatesInputValidator.isValidLongitude("-181"), "Longitude -181 should be invalid")
        XCTAssertFalse(CoordinatesInputValidator.isValidLongitude("200"), "Longitude 200 should be invalid")
        XCTAssertFalse(CoordinatesInputValidator.isValidLongitude("180.1"), "Longitude 180.1 should be invalid")
        XCTAssertFalse(CoordinatesInputValidator.isValidLongitude("abc"), "Longitude 'abc' should be invalid")
    }
}

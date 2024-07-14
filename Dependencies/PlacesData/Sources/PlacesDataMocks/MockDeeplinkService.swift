//
//  MockDeeplinkService.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
@testable import PlacesData

public final class MockDeeplinkService: DeeplinkServiceProtocol {
    public var openedLocation: Location?

    public func openWiki(location: Location) {
        openedLocation = location
    }
}

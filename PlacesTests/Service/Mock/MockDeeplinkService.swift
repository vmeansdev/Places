//
//  MockDeeplinkService.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
@testable import Places

final class MockDeeplinkService: DeeplinkServiceProtocol {
    var openedLocation: Location?

    func openWiki(location: Location) {
        openedLocation = location
    }
}

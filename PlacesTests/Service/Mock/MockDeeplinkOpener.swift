//
//  MockDeeplinkOpener.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
@testable import Places

class MockDeeplinkOpener: DeeplinkOpenerProtocol {
    var lastOpenedURL: URL?

    func openDeeplink(_ url: URL) {
        lastOpenedURL = url
    }
}

//
//  MockDeeplinkOpener.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation
@testable import PlacesData

public final class MockDeeplinkOpener: DeeplinkOpenerProtocol {
    public var lastOpenedURL: URL?

    public func openDeeplink(_ url: URL) {
        lastOpenedURL = url
    }
}

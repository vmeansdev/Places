//
//  DeeplinkService.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import Foundation
import UIKit

protocol DeeplinkOpenerProtocol {
    func openDeeplink(_ url: URL)
}

extension UIApplication: DeeplinkOpenerProtocol {
    func openDeeplink(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

protocol DeeplinkServiceProtocol {
    func openWiki(location: Location)
}

final class DeeplinkService: DeeplinkServiceProtocol {
    private let deeplinkOpener: DeeplinkOpenerProtocol

    init(deeplinkOpener: DeeplinkOpenerProtocol) {
        self.deeplinkOpener = deeplinkOpener
    }

    func openWiki(location: Location) {
        guard let url = buildURL(location: location) else {
            return
        }
        deeplinkOpener.openDeeplink(url)
    }

    private func buildURL(location: Location) -> URL? {
        guard let baseURL = URL(string: "wikipedia://places") else {
            return nil
        }
        let latitudeQueryItem = URLQueryItem(name: Constants.latitudeKey, value: "\(location.latitude)")
        let longitudeQueryItem = URLQueryItem(name: Constants.longitudeKey, value: "\(location.longitude)")
        let placeNameQueryItem = location.name.flatMap { URLQueryItem(name: Constants.placeNameKey, value: $0) }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [latitudeQueryItem, longitudeQueryItem, placeNameQueryItem].compactMap { $0 }
        return components?.url
    }

    private enum Constants {
        static let latitudeKey = "lat"
        static let longitudeKey = "long"
        static let placeNameKey = "place_name"
    }
}

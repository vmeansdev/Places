//
//  Location.swift
//  Places
//
//  Created by Nikita Kononenko on 13.07.2024.
//

import Foundation

public struct Location: Codable, Identifiable, Equatable {
    public let id = UUID()
    public let name: String?
    public let latitude: Double
    public let longitude: Double

    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }

    public init(name: String?, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
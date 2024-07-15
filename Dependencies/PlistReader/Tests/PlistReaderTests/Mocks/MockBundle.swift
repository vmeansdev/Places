//
//  MockBundle.swift
//
//
//  Created by Nikita Kononenko on 15.07.2024.
//

import Foundation

class MockBundle: Bundle {
    private let mockInfoDictionary: [String: Any]

    init(infoDictionary: [String: Any]) {
        self.mockInfoDictionary = infoDictionary
        super.init()
    }

    override func object(forInfoDictionaryKey key: String) -> Any? {
        return mockInfoDictionary[key]
    }
}

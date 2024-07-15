//
//  PlistReader.swift
//  PlistReader
//
//  Created by Nikita Kononenko on 15/06/2024.
//

import Foundation

public class PlistReader {
    public enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    private let bundle: Bundle

    public init(bundle: Bundle) {
        self.bundle = bundle
    }

    public func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = bundle.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

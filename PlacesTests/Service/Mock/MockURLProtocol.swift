//
//  MockURLProtocol.swift
//  PlacesTests
//
//  Created by Nikita Kononenko on 14.07.2024.
//

import Foundation

class MockURLProtocol: URLProtocol {
    enum MockURLProtocolError: Error {
        case notFound
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url,
           let fileName = url.lastPathComponent.components(separatedBy: ".").first,
           let filePath = Bundle(for: type(of: self)).path(forResource: "\(fileName)", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        {
            let response = URLResponse(url: url, mimeType: "application/json", expectedContentLength: data.count, textEncodingName: nil)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } else {
            client?.urlProtocol(self, didFailWithError: MockURLProtocolError.notFound)
        }
    }

    override func stopLoading() {
        // No cleanup necessary
    }
}

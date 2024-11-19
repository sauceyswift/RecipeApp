//
//  URLProtocolMock.swift
//  RecipeAppTests
//
//  Created by Michael Ceryak on 11/18/24.
//

import Foundation

final class URLProtocolMock: URLProtocol {
    // this is the data we're expecting to send back
    static var testData: Data?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))? = { request in
        guard let url = request.url, let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            fatalError("unable to mock request handler")
        }
        return (response, testData ?? Data())
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    // as soon as loading starts, send back our test data or an empty Data instance, then end loading
    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Handler not available")
        }
        do {
            let (response, data) = try handler(request)
            
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }
            self.client?.urlProtocolDidFinishLoading(self)
        } catch {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() { }
}

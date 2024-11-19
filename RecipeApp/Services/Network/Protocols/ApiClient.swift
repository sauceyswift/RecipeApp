//
//  ApiClient.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import Foundation

protocol ApiClient {
    func request<E: ApiEndpoint, T: Decodable>(_ endpoint: E, session: URLSession) async throws -> T
}

extension ApiClient {
    func request<E: ApiEndpoint, T: Decodable>(_ endpoint: E, session: URLSession = .shared) async throws -> T {
        return try await request(endpoint, session: session)
    }
}

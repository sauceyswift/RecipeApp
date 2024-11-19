//
//  UrlSessionApiClient.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import Foundation

final class UrlSessionApiClient: ApiClient {
    
    func request<E: ApiEndpoint, T: Decodable>(_ endpoint: E, session: URLSession = .shared) async throws -> T {
        guard let url = endpoint.baseUrl?.appendingPathComponent(endpoint.path, conformingTo: .json) else {
            throw ApiError.invalidUrl(endpoint.baseUrl?.absoluteString ?? "" + endpoint.path)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        let (data, _) = try await session.data(for: request)
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw ApiError.malformedData(error.localizedDescription)
        }
        
    }
    
}

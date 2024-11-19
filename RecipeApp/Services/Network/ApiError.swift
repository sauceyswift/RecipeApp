//
//  ApiError.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import Foundation

enum ApiError: LocalizedError {
    case malformedData(String)
    case invalidUrl(String)
    
    var errorDescription: String? {
        switch self {
        case .malformedData(let errorDescription): return "Error. Malformed Data: \(errorDescription)"
        case .invalidUrl(let errorDescription): return "Invalid URL: \(errorDescription)"
        }
    }
    // ...
}

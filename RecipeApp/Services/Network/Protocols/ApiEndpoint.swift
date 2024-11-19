//
//  ApiEndpoint.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import Foundation

protocol ApiEndpoint {
    var baseUrl: URL? { get }
    var path: String { get }
    var method: HttpMethod { get }
    // ...
}

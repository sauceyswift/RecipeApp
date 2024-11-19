//
//  RecipesEndpoint.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import Foundation

enum RecipesEndpoint: String, ApiEndpoint, CaseIterable, Identifiable {
    case getAllRecipes = "Get All Recipes"
    case getMalformedData = "Get Malformed Data"
    case getEmptyData = "Get Empty Data"
    
    var id: String { return self.rawValue }
    
    var baseUrl: URL? {
        URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")
    }
    
    var path: String {
        switch self {
        case .getAllRecipes: "/recipes.json"
        case .getMalformedData: "/recipes-malformed.json"
        case .getEmptyData: "/recipes-empty.json"
        }
    }
    
    var method: HttpMethod {
        switch self {
        default: .get
        }
    }
}

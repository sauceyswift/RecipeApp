//
//  Recipe.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/11/24.
//

import Foundation

struct Recipe: Codable, Identifiable, Hashable {
    var id: String { uuid }
    
    let uuid: String
    let cuisine: String
    let name: String
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let youtube_url: String?
    
    var photoUrlSmall: URL? {
        guard let urlString = photo_url_small else { return nil }
        return URL(string: urlString)
    }
    
    var photoUrlLarge: URL? {
        guard let urlString = photo_url_large else { return nil }
        return URL(string: urlString)
    }
}

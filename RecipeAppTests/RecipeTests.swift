//
//  RecipeTests.swift
//  RecipeAppTests
//
//  Created by Michael Ceryak on 11/19/24.
//

import XCTest
@testable import RecipeApp

final class RecipeTests: XCTestCase {
    
    func testPhotoUrlSmall() {
        let recipe = Recipe(uuid: "1", cuisine: "American", name: "Cheeseburger", photo_url_large: nil, photo_url_small: "www.google.com", source_url: nil, youtube_url: nil)
        
        let url = recipe.photoUrlSmall
        XCTAssertNotNil(url)
        XCTAssertEqual("www.google.com", url?.absoluteString)
    }
    
    func testPhotoUrlLarge() {
        let recipe = Recipe(uuid: "1", cuisine: "American", name: "Cheeseburger", photo_url_large: "www.google.com", photo_url_small: nil, source_url: nil, youtube_url: nil)
        
        let url = recipe.photoUrlLarge
        XCTAssertNotNil(url)
        XCTAssertEqual("www.google.com", url?.absoluteString)
    }
    
}

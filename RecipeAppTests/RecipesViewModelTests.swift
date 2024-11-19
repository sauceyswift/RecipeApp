//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Michael Ceryak on 11/11/24.
//

import XCTest
@testable import RecipeApp

final class RecipesViewModelTests: XCTestCase {
    
    static let testRecipes = [
        Recipe(uuid: "1", cuisine: "American", name: "Cheeseburger", photo_url_large: "large1.com", photo_url_small: "small1.com", source_url: "source1.com", youtube_url: "yt1.com"),
        Recipe(uuid: "2", cuisine: "British", name: "Fish & Chips", photo_url_large: "large2.com", photo_url_small: "small2.com", source_url: "source2.com", youtube_url: "yt2.com")
    ]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoadRecipesSuccess() async {
        MockRecipeApiClient.throwApiError = false
        MockRecipeApiClient.throwUnknownError = false
        
        await RecipesViewModel.shared.loadRecipes(client: MockRecipeApiClient())
        
        let isLoading = await RecipesViewModel.shared.isLoading
        XCTAssertFalse(isLoading)
        
        guard let recipes = await RecipesViewModel.shared.recipes else {
            XCTAssert(false, "recipes is nil")
            return
        }
        XCTAssertEqual(RecipesViewModelTests.testRecipes[0], recipes[0])
        XCTAssertEqual(RecipesViewModelTests.testRecipes[1], recipes[1])
    }
    
    func testLoadRecipesApiError() async {
        MockRecipeApiClient.throwApiError = true
        MockRecipeApiClient.throwUnknownError = false
        
        await RecipesViewModel.shared.loadRecipes(client: MockRecipeApiClient())
        
        let isLoading = await RecipesViewModel.shared.isLoading
        XCTAssertFalse(isLoading)
        
        let recipes = await RecipesViewModel.shared.recipes
        XCTAssertNil(recipes)
        
        let error = await RecipesViewModel.shared.error
        XCTAssertEqual("Error. Malformed Data: bad data", error)
        
    }
    
    func testLoadRecipesUnknownError() async {
        MockRecipeApiClient.throwApiError = false
        MockRecipeApiClient.throwUnknownError = true
        await RecipesViewModel.shared.loadRecipes(client: MockRecipeApiClient())
        
        let isLoading = await RecipesViewModel.shared.isLoading
        XCTAssertFalse(isLoading)
        
        let recipes = await RecipesViewModel.shared.recipes
        XCTAssertNil(recipes)
        
        let error = await RecipesViewModel.shared.error
        XCTAssertNotNil(error)
        
    }
    
    final class MockRecipeApiClient: ApiClient {
        
        static var throwApiError: Bool = false
        static var throwUnknownError: Bool = false
        
        func request<E: ApiEndpoint, T: Decodable>(_ endpoint: E, session: URLSession = .shared) async throws -> T {
            if MockRecipeApiClient.throwApiError {
                throw ApiError.malformedData("bad data")
            }
            if MockRecipeApiClient.throwUnknownError {
                throw URLError(.badURL)
            }
            return GetRecipesResult(recipes:  RecipesViewModelTests.testRecipes) as! T
        }
    }

}

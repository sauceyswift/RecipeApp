//
//  RecipesApiTests.swift
//  RecipeAppTests
//
//  Created by Michael Ceryak on 11/18/24.
//

import XCTest
@testable import RecipeApp

final class RecipesApiTests: XCTestCase {
    
    let validRecipeData: String = """
            {
                "recipes": [
                    {
                        "cuisine": "British",
                        "name": "Bakewell Tart",
                        "photo_url_large": "https://some.url/1/large.jpg",
                        "photo_url_small": "https://some.url/1/small.jpg",
                        "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb1",
                        "source_url": "https://some.url/1/index.html",
                        "youtube_url": "https://www.youtube.com/watch?v=1"
                    },
                    {
                        "cuisine": "American",
                        "name": "Cheeseburger",
                        "photo_url_large": "https://some.url/2/large.jpg",
                        "photo_url_small": "https://some.url/2/small.jpg",
                        "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb2",
                        "source_url": "https://some.url/2/index.html",
                        "youtube_url": "https://www.youtube.com/watch?v=2"
                    }
                ]
            }
        """
    let malformedRecipeData: String = """
            {
                "recipes": [
                    {
                        "cuisine": "Italian",
                        "name": "Budino Di Ricotta",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/2cac06b3-002e-4df7-bb08-e15bbc7e552d/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/2cac06b3-002e-4df7-bb08-e15bbc7e552d/small.jpg",
                        "source_url": "https://thehappyfoodie.co.uk/recipes/ricotta-cake-budino-di-ricotta",
                        "uuid": "563dbb27-5323-443c-b30c-c221ae598568",
                        "youtube_url": "https://www.youtube.com/watch?v=6dzd6Ra6sb4"
                    },
                    {
                        "cuisine": "Canadian",
                        "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/large.jpg",
                        "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/small.jpg",
                        "source_url": "https://www.bbcgoodfood.com/recipes/1837/canadian-butter-tarts",
                        "uuid": "39ad8233-c470-4394-b65f-2a6c3218b935"
                    }
                ]
            }
        """
    
    func testGetMalformedData() async {
        URLProtocolMock.testData = Data(malformedRecipeData.utf8)
        do {
            let _: GetRecipesResult = try await UrlSessionApiClient().request(RecipesEndpoint.getMalformedData, session: session)
            XCTAssert(false, "Error should have been thrown")
        } catch ApiError.malformedData(let description) {
            XCTAssertEqual("The data couldn’t be read because it is missing.", description)
        } catch {
            XCTAssert(false, "Unexpected error: \(error.localizedDescription)")
        }
    }
    
    func testGetAllRecipes() async {
        URLProtocolMock.testData = Data(validRecipeData.utf8)
        do {
            let result: GetRecipesResult = try await UrlSessionApiClient().request(RecipesEndpoint.getAllRecipes, session: session)
            XCTAssertEqual(2, result.recipes.count)
            assertRecipe(recipe: result.recipes[0], name: "Bakewell Tart", cuisine: "British", id: 1)
            assertRecipe(recipe: result.recipes[1], name: "Cheeseburger", cuisine: "American", id: 2)
        } catch {
            XCTAssert(false, "error: \(error.localizedDescription)")
        }
    }
    
    func testGetEmptyData() async {
        let mockResponse = "{ \"recipes\": [] }"
        URLProtocolMock.testData = Data(mockResponse.utf8)
        do {
            let result: GetRecipesResult = try await UrlSessionApiClient().request(RecipesEndpoint.getAllRecipes, session: session)
            XCTAssertEqual(0, result.recipes.count)
        } catch {
            XCTAssert(false, "error: \(error.localizedDescription)")
        }
    }
    
    private var session: URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        return session
    }
    
    private func assertRecipe(recipe: Recipe, name: String, cuisine: String, id: Int) {
        XCTAssertEqual(name, recipe.name)
        XCTAssertEqual(cuisine, recipe.cuisine)
        XCTAssertEqual("https://some.url/\(id)/large.jpg", recipe.photo_url_large)
        XCTAssertEqual("https://some.url/\(id)/small.jpg", recipe.photo_url_small)
        XCTAssertEqual("eed6005f-f8c8-451f-98d0-4088e2b40eb\(id)", recipe.uuid)
        XCTAssertEqual("https://some.url/\(id)/index.html", recipe.source_url)
        XCTAssertEqual("https://www.youtube.com/watch?v=\(id)", recipe.youtube_url)
    }
    
}

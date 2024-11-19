//
//  RecipesService.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import Foundation


@MainActor
@Observable
final class RecipesViewModel {
    
    static let shared = RecipesViewModel()
    
    private(set) var isLoading: Bool = false
    private(set) var recipes: [Recipe]?
    private(set) var error: String?
    
    var path: RecipesEndpoint = .getAllRecipes {
        didSet {
            Task {
                await loadRecipes()
            }
        }
    }
    
    private init() { }
    
    
    @MainActor func loadRecipes(client: ApiClient = UrlSessionApiClient()) async {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
        self.error = nil
        do {
            let result: GetRecipesResult = try await client.request(self.path)
            self.recipes = result.recipes
        } catch let apiErr as ApiError {
            self.recipes = nil
            self.error = apiErr.errorDescription
        } catch {
            self.recipes = nil
            self.error = "Unknown Error: \(error.localizedDescription)"
        }
    }
    
}

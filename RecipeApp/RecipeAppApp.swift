//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/11/24.
//

import SwiftUI

@main
struct RecipeAppApp: App {
    
    init() {
        Task {
            await RecipesViewModel.shared.loadRecipes()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

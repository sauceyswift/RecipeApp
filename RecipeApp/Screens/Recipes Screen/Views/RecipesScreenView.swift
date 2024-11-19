//
//  RecipesScreenView.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import SwiftUI

@MainActor
struct RecipesScreenView: View {
    
    @State private var VM = RecipesViewModel.shared
    
    var body: some View {
        screenContent
            .navigationTitle("Recipes")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu("", systemImage: "line.3.horizontal") {
                        ForEach(RecipesEndpoint.allCases) { endpoint in
                            Button(endpoint.rawValue) {
                                VM.path = endpoint
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "arrow.clockwise") {
                        Task {
                            await VM.loadRecipes()
                        }
                    }
                    .disabled(VM.isLoading)
                }
            }
    }
    
    @ViewBuilder private var screenContent: some View {
        if VM.isLoading {
            ProgressView("Loading Recipes")
        } else if let _ = VM.error {
            List {
                Text("ERROR: Unable to load the recipes from the server.")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }
            .scrollContentBackground(.hidden)
        } else if let recipes = VM.recipes {
            RecipesListView(recipes: recipes)
        }
    }
}

#Preview {
    NavigationStack {
        RecipesScreenView()
            .gradientBackground()
    }
}

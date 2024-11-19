//
//  RecipesListView.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/11/24.
//

import SwiftUI


@MainActor
struct RecipesListView: View {
    
    let recipes: [Recipe]
    
    var body: some View {
        
        List {
            if recipes.isEmpty {
                Text("No recipes found.")
                    .fontWeight(.semibold)
                    .italic()
                    .frame(maxWidth: .infinity)
                    .listRowBackground(Color.clear)
            } else {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipesListItemView(recipe: recipe)
                    }
                    .listRowSeparator(.hidden)
                }
            }
        }
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
        
    }
    
}


#Preview {
    NavigationStack {
        RecipesScreenView()
            .gradientBackground()
    }
}

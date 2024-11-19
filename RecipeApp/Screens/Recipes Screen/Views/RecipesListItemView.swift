//
//  RecipesListItemView.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import SwiftUI
import NukeUI

@MainActor
struct RecipesListItemView: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack {
            LazyImage(url: recipe.photoUrlSmall) { imageState in
                if let error = imageState.error {
                    Text(error.localizedDescription)
                } else if let image = imageState.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .withRoundedCorners()
                        .shadow(radius: 10)
                }
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .fontWeight(.bold)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .italic()
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            NavigationLink(value: Recipe.exampleRecipe) {
                RecipesListItemView(recipe: .exampleRecipe)
            }
        }
    }
}

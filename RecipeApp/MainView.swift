//
//  NavigationContainerView.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            RecipesScreenView()
                .gradientBackground()
        }
    }
}

#Preview {
    MainView()
}

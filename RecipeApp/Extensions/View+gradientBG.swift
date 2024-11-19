//
//  View+gradientBG.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import SwiftUI

extension View {
    
    @MainActor
    func gradientBackground() -> some View {
        ZStack {
            LinearGradient(colors: [.green.opacity(0.1), Color(red: 16/255, green: 50/255, blue: 55/255)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            self
        }
    }
}

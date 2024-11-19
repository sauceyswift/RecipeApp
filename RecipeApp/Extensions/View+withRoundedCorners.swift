//
//  View+withRoundedCorners.swift
//  RecipeApp
//
//  Created by Michael Ceryak on 11/18/24.
//

import SwiftUI

extension View {
    @MainActor
    func withRoundedCorners(cornerRadius: Double = 10) -> some View {
        self.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

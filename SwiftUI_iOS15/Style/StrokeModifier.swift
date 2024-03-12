//
//  SwiftUIView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 23.02.2024.
//

import SwiftUI

struct StrokeModifier: ViewModifier {
    var cornerRadius: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(
                cornerRadius: cornerRadius, style: .continuous
            )
            .stroke(
                .linearGradient(
                    colors: [
                        .white.opacity(colorScheme == .dark ? 0.3 : 0.6),
                        .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .blendMode(.overlay)
        )
    }
}

extension View {
    func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
        modifier(StrokeModifier(cornerRadius: cornerRadius))
    }
}

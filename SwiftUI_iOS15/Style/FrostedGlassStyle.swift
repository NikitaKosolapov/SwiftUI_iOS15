//
//  RoundedRectangleStyle.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 29.02.2024.
//

import SwiftUI

struct FrostedGlassStyle: ViewModifier {
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .strokeStyle(cornerRadius: cornerRadius)
    }
}

extension View {
    func frostedGlassStyle(cornerRadius: CGFloat) -> some View {
        modifier(FrostedGlassStyle(cornerRadius: cornerRadius))
    }
}

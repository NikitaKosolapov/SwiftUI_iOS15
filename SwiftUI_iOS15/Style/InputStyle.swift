//
//  SwiftUIView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 03.03.2024.
//

import SwiftUI

struct InputStyle: ViewModifier {
    var icon: String
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 15)
            .padding(.leading, 56)
            .frostedGlassStyle(cornerRadius: 20)
            .overlay(
                Image(systemName: icon)
                    .foregroundStyle(.secondary)
                    .frame(width: 36, height: 36)
                    .frostedGlassStyle(cornerRadius: 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
            )
    }
}

extension View {
    func inputStyle(icon: String) -> some View {
        modifier(InputStyle(icon: icon))
    }
}

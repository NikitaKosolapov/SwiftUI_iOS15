//
//  SectionTitleModifier.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 12.03.2024.
//

import SwiftUI

struct SectionTitleModifier: ViewModifier {
    var insets: EdgeInsets
    
    func body(content: Content) -> some View {
        content
            .font(.footnote.weight(.semibold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(insets)
    }
}

extension View {
    func sectionTitle(insets: EdgeInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)) -> some View {
        modifier(SectionTitleModifier(insets: insets))
    }
}

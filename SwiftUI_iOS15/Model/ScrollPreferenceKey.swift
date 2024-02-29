//
//  ScrollPreferenceKey.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 26.02.2024.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        defaultValue = nextValue()
    }
}

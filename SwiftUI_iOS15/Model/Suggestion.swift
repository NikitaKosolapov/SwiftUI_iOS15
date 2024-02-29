//
//  Suggestion.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 29.02.2024.
//

import SwiftUI

struct Suggestion: Identifiable {
    let id = UUID()
    let text: String
}

var suggestions = [
    Suggestion(text: "SwiftUI"),
    Suggestion(text: "Flutter"),
    Suggestion(text: "UIDesign")
]

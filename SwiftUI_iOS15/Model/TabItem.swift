//
//  TabItem.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 25.02.2024.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: String
    var tab: Tab
    var color: Color
}

var tabItems = [
    TabItem(text: "Learn Now", icon: "house", tab: .home, color: .teal),
    TabItem(text: "Explore", icon: "magnifyingglass", tab: .explore, color: .blue),
    TabItem(text: "Notifications", icon: "bell", tab: .notifications, color: .red),
    TabItem(text: "Library", icon: "rectangle.stack.badge.play", tab: .library, color: .purple)
]

enum Tab: Int {
    case home
    case explore
    case notifications
    case library
}

//
//  Topic.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 10.03.2024.
//

import SwiftUI

struct Topic: Identifiable {
    let id = UUID()
    var title: String
    var icon: String
}

var topics = [
    Topic(title: "iOS Development", icon: "iphone"),
    Topic(title: "UI Design", icon: "eyedropper"),
    Topic(title: "Web development", icon: "laptopcomputer")
]

var libraryTopics = [
    Topic(title: "History", icon: "clock.fill"),
    Topic(title: "Favorites", icon: "star.fill"),
    Topic(title: "Downloads", icon: "square.and.arrow.down.fill")
]

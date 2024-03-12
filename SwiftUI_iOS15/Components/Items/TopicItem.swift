//
//  TopicItem.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 10.03.2024.
//

import SwiftUI

struct TopicItem: View {
    var topic: Topic = topics[0]
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: topic.icon)
                .font(.body.weight(.bold))
                .frame(width: 36, height: 36)
                .frostedGlassStyle(cornerRadius: 18)
            
            Text(topic.title)
                .font(.body.weight(.semibold))
        }
    }
}

#Preview {
    TopicItem()
}

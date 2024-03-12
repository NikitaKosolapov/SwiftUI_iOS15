//
//  CircleProgressView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 07.03.2024.
//

import SwiftUI

struct CircleProgressView: View {
    var lineWidth: CGFloat = 4
    @State var progress: CGFloat = 0.5
    
    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            .fill(.angularGradient(colors: [.purple, .pink, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
            .rotationEffect(.degrees(270))
    }
}

#Preview {
    CircleProgressView()
}

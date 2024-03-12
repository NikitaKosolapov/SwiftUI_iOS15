//
//  HandbookItem.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 12.03.2024.
//

import SwiftUI

struct HandbookItem: View {
    var handbook: Handbook = handbooks[0]
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Image(handbook.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 100)
                    )
                    .overlay(alignment: .bottomLeading) {
                        Image(handbook.logo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26, height: 26)
                            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
            }
            .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16))
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(handbook.title)
                    .font(.body.weight(.semibold))
                    .lineLimit(2)
                
                Text(handbook.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Text(handbook.text)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                
                ProgressView(value: handbook.progress)
                    .tint(.white)
            }
            .padding(16)
        }
        .frostedGlassStyle(cornerRadius: 30)
        .frame(maxWidth: 200)
        .frame(height: 260)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.linearGradient(colors: [handbook.color1, handbook.color2], startPoint: .bottomLeading, endPoint: .top))
                .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0), anchor: .bottomTrailing)
                .rotationEffect(.degrees(180))
                .padding(.trailing, 30)
        )
    }
}

#Preview {
    HandbookItem()
}

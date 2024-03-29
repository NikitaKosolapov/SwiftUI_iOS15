//
//  FeatureItem.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 25.02.2024.
//

import SwiftUI

struct FeatureItem: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    var course: Course = courses[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            Image(course.logo)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 26.0, height: 26.0)
                .cornerRadius(10)
                .padding(9)
                .frostedGlassStyle(cornerRadius: 20)
            Text(course.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .lineLimit(1)
            Text(course.subtitle.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Text(course.text)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(dynamicTypeSize > .large ? 1 : 2)
                .frame(maxWidth: .infinity, alignment: .leading) // don't use HStack, use .infinity
                .foregroundColor(.secondary)
        }
        .padding(.all, 20.0)
        .frame(height: 350.0)
        .frostedGlassStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
        .frame(maxWidth: 500)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.allowsDirectInteraction)
    }
}

struct FeatureItem_Previews: PreviewProvider {
    static var previews: some View {
        FeatureItem()
    }
}

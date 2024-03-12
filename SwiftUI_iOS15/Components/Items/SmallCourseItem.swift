//
//  SmallCourseItem.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 07.03.2024.
//

import SwiftUI

struct SmallCourseItem: View {
    var course = courseSections[3]
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .frame(width: 128, height: 90)
                    .overlay(
                        Image(course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 105)
                            .offset(y: 0)
                    )
                    .overlay(alignment: .bottomLeading) {
                        Image(course.logo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 26, height: 26)
                            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
            }
            .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(course.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Text(course.title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(width: 160, height: 204)
        .frostedGlassStyle(cornerRadius: 30)
        .shadow(color: .clear, radius: 0)
        .shadow(color: Color("Shadow").opacity(0.15), radius: 30, x: 0, y: 30)
    }
}

#Preview {
    SmallCourseItem()
}

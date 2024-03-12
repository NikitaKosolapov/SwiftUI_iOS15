//
//  SectionView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 07.03.2024.
//

import SwiftUI

struct SectionRow: View {
    var courseSection: CourseSection = courseSections[0]
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(courseSection.logo)
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())
                .padding(13)
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
                .overlay(CircleProgressView(progress: courseSection.progress))

            VStack(alignment: .leading, spacing: 4) {
                Text(courseSection.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                Text(courseSection.title)
                    .font(.body)
                    .fontWeight(.bold)
                Text(courseSection.text)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                ProgressView(value: courseSection.progress)
                    .tint(.white)
                    .frame(maxWidth: 132)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    SectionRow()
}

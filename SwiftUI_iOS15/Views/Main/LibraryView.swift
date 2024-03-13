//
//  LibraryView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 12.03.2024.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                courseSection
                
                topicsSection
                
                certificateSection
                
                Spacer()
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(hasScrolled: .constant(true), title: "Library")
            )
            .background(Image("Background 2").offset(x: -100, y: -100))
        }
    }
    
    var courseSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(courseSections) { course in
                    SmallCourseItem(course: course)
                }
            }
            .padding(.vertical, 80)
            .padding(.horizontal, 20)
        }
        .padding(.vertical, -80)
    }
    
    var topicsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(libraryTopics.enumerated()), id: \.offset) { index, topic in
                if index != 0 { Divider() }
                TopicItem(topic: topic)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .frostedGlassStyle(cornerRadius: 30)
        .padding(.top, 20)
        .shadow(color: .clear, radius: 0, x: 0, y: 0)
        .shadow(color: Color("Shadow").opacity(0.15), radius: 30, x: 0, y: 30)
        .padding(.horizontal, 20)
    }
    
    var certificateSection: some View {
        VStack {
            Text("Certificates".uppercased())
                .sectionTitle()
            
            CertificateView()
        }
    }
}

#Preview {
    LibraryView()
}

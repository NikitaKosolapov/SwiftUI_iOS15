//
//  ExploreView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 07.03.2024.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                courseSection
                
                topicsSection
                
                handbookSection
                
                Spacer()
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(hasScrolled: .constant(true), title: "Recent")
            )
            .background(Image("Blob 1").offset(x: -100, y: -400))
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
        VStack {
            Text("topics".uppercased())
                .font(.footnote.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 26)
            
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(topics.enumerated()), id: \.offset) { index, topic in
                    if index != 0 { Divider() }
                    TopicItem(topic: topic)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            .frostedGlassStyle(cornerRadius: 30)
            .shadow(color: .clear, radius: 0, x: 0, y: 0)
            .shadow(color: Color("Shadow").opacity(0.15), radius: 30, x: 0, y: 30)
            .padding(.horizontal, 20)
        }
    }
    
    var handbookSection: some View {
        VStack {
            Text("popular".uppercased())
                .font(.footnote.weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 26)
            
            HStack(alignment: .top, spacing: 30) {
                ForEach(handbooks) { handbook in
                    HandbookItem(handbook: handbook)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    ExploreView()
}

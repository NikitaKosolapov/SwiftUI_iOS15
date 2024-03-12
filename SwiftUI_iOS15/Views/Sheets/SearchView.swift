//
//  SearchView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 29.02.2024.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @Namespace var namespace
    @State var text: String = ""
    @State var selectedIndex = 0
    @State var showCourse = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                content
            }
            .background(Image("Background 2"))
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showCourse, content: {
                CourseView(namespace: namespace, course: courses[selectedIndex], show: $showCourse)
            })
        }
        .ignoresSafeArea()
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(courses.enumerated()), id: \.offset) { index, course in
                if course.title.contains(text) || text == "" {
                    VStack(spacing: 12) {
                        if index != 0 {
                            Divider()
                        }
                        
                        Button {
                            showCourse = true
                            selectedIndex = index
                        } label: {
                            HStack(spacing: 16) {
                                Image(systemName: "magnifyingglass")
                                    .font(.body.bold())
                                    .padding(8)
                                    .frostedGlassStyle(cornerRadius: 18)
                                Text(course.title)
                                    .font(.body.weight(.semibold))
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
        .frostedGlassStyle(cornerRadius: 20)
        .padding(20)
    }
}

#Preview {
    SearchView()
}

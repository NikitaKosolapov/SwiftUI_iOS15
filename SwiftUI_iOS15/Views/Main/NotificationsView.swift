//
//  NotificationsView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 12.03.2024.
//

import SwiftUI

struct NotificationsView: View {
    @State var selectedIndex: Int = 1
    @State var showSection: Bool = false
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                content
                    .sheet(isPresented: $showSection, content: {
                        SectionView(courseSection: courseSections[selectedIndex])
                    })
                
                Spacer()
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(hasScrolled: .constant(true), title: "Notifications")
            )
            .background(Image("Background 2"))
        }
    }
    
    var content: some View {
        VStack(spacing: 16) {
            ForEach(Array(courseSections.enumerated()), id: \.offset) { index, section in
                if index != 0 { Divider() }
                SectionRow(courseSection: section)
                    .onTapGesture {
                        selectedIndex = index
                        showSection = true
                    }
            }
        }
        .padding(20)
        .frostedGlassStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
}

#Preview {
    NotificationsView()
}

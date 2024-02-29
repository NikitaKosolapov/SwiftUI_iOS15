//
//  SwiftUIView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 25.02.2024.
//

import SwiftUI

struct TabBar: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @State var color: Color = .teal
    @State var tabBarWidth: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            let hasBottomInset = proxy.safeAreaInsets.bottom > 0
            
            buttons
                .padding(.top, 17)
                .padding(.horizontal, 8)
                .frame(height: hasBottomInset ? 118 : 96, alignment: .top)
                .strokeStyle(cornerRadius: hasBottomInset ? 30 : 0)
                .frostedGlassStyle(cornerRadius: hasBottomInset ? 30 : 0)
                .background(
                    background
                )
                .overlay(
                    overlay
                )
                .offset(y: 30)
                .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
    
    var buttons: some View {
        HStack {
            ForEach(tabItems) { item in
                Button {
                    withAnimation(.snappy) {
                        selectedTab = item.tab
                        color = item.color
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: item.icon)
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 48, height: 20)
                        Text(item.text)
                            .font(.caption2)
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                }
                .foregroundStyle(
                    selectedTab == item.tab
                    ? .primary
                    : .secondary
                )
                .blendMode(selectedTab == item.tab ? .overlay : .normal)
                .overlay(
                    GeometryReader { proxy in
                        Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
                    }
                        .onPreferenceChange(TabPreferenceKey.self) { value in
                            tabBarWidth = value
                        }
                )
            }
        }
    }
    
    var background: some View {
        HStack {
            if selectedTab == .explore { Spacer() }
            if selectedTab == .library { Spacer() }
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            
            Circle()
                .foregroundColor(color)
                .frame(width: tabBarWidth)
            if selectedTab == .notifications { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .home { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
    var overlay: some View {
        HStack {
            if selectedTab == .explore { Spacer() }
            if selectedTab == .library { Spacer() }
            if selectedTab == .notifications {
                Spacer()
                Spacer()
            }
            
            Rectangle()
                .foregroundColor(color)
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: tabBarWidth)
            if selectedTab == .notifications { Spacer() }
            if selectedTab == .explore {
                Spacer()
                Spacer()
            }
            if selectedTab == .home { Spacer() }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 8)
    }
}

struct TabPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}

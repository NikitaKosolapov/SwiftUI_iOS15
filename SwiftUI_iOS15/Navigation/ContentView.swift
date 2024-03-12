//
//  ContentView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 23.02.2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("showModal") var showModal: Bool = false
    @AppStorage("selectedTab") var selectedTab: Tab = .home
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            switch selectedTab {
            case .home:
                HomeView()
            case .explore:
                ExploreView()
            case .notifications:
                AccountView()
            case .library:
                AccountView()
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
            
            if showModal {
                SignUpView()
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            Color.clear.frame(height: 44)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}

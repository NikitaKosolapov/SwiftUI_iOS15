//
//  NavigationBar.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 25.02.2024.
//

import SwiftUI

struct NavigationBar: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @AppStorage("showModal") var showModal: Bool = false
    @AppStorage("isLogged") var isLogged: Bool = false
    @State var showSearch = false
    @State var showAccount = false
    @Binding var hasScrolled: Bool
    var title: String = ""
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            Text("Featured")
                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)
            
            HStack(spacing: 16) {
                Button {
                    showSearch = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.body.weight(.bold))
                        .foregroundStyle(.secondary)
                        .frame(width: 36, height: 36)
                        .frostedGlassStyle(cornerRadius: 16)
                }
                .sheet(isPresented: $showSearch, content: {
                    SearchView()
                })
                
                Button {
                    if isLogged {
                        showAccount = true
                    } else {
                        withAnimation(.easeInOut) {
                            showModal = true
                        }
                    }
                } label: {
                    AvatarView()
                }
                .sheet(isPresented: $showAccount, content: {
                    AccountView()
                })
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .offset(y: hasScrolled ? -4 : 0)
            .padding(.top, 20)
            .padding(.trailing, 20)
        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(hasScrolled: .constant(false))
    }
}

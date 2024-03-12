//
//  AvatarView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 07.03.2024.
//

import SwiftUI

struct AvatarView: View {
    @AppStorage("isLogged") var isLogged = false
    
    var body: some View {
        if isLogged {
            AsyncImage(url: URL(string: "https://picsum.photos/200"), transaction: Transaction(animation: .easeInOut)) { phase in
                switch phase {
                case .empty:
                    Color.clear
                        .frame(width: 26, height: 26)
                        .cornerRadius(10)
                        .padding(9)
                        .frostedGlassStyle(cornerRadius: 20)
                    
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 26, height: 26)
                        .cornerRadius(10)
                        .padding(9)
                        .transition(.scale(scale: 0.5, anchor: .center))
                        .frostedGlassStyle(cornerRadius: 20)
                case .failure:
                    defaultAvatar
                @unknown default:
                    defaultAvatar
                }
            }
        } else {
            defaultAvatar
        }
    }
    
    var defaultAvatar: some View {
        Image("Avatar Default")
            .resizable()
            .frame(width: 26, height: 26)
            .cornerRadius(10)
            .padding(9)
            .transition(.scale(scale: 0.5, anchor: .center))
            .frostedGlassStyle(cornerRadius: 20)
    }
}

#Preview {
    AvatarView()
}

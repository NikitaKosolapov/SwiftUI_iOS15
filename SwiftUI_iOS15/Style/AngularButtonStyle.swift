//
//  AngularButtonStyle.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 01.03.2024.
//

import SwiftUI

struct AngularButton: View {
    var body: some View {
        ZStack {
            Image("Background 1")
            
            Button {
                
            } label: {
                Text("Button")
            }
            .buttonStyle(.angular)
        }
    }
}

struct AngularButtonStyle: ButtonStyle {
    @Environment(\.controlSize) var controlSize
    
    var extraPadding: CGFloat {
        switch controlSize {
        case .mini:
            return 0
        case .small:
            return 0
        case .regular:
            return 4
        case .large:
            return 12
        case .extraLarge:
            return 16
        @unknown default:
            return 4
        }
    }
    
    var cornerRadius: CGFloat {
        switch controlSize {
        case .mini:
            return 12
        case .small:
            return 12
        case .regular:
            return 16
        case .large:
            return 20
        case .extraLarge:
            return 26
        @unknown default:
            return 16
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 4 + extraPadding)
            .padding(.horizontal, 10 + extraPadding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.linearGradient(colors: [.blue, .pink], startPoint: .leading, endPoint: .trailing))
                    .blendMode(.softLight)
            )
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.angularGradient(colors: [.pink, .blue, .purple, .green], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                    .blur(radius: cornerRadius)
            )
            .blendMode(.overlay)
            .strokeStyle(cornerRadius: cornerRadius)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

extension ButtonStyle where Self == AngularButtonStyle {
    static var angular: Self {
        .init()
    }
}

#Preview {
    AngularButton()
}

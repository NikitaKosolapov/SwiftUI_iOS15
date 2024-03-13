//
//  CertificateView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 12.03.2024.
//

import SwiftUI

struct CertificateView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("SwiftUI for iOS 15")
                    .font(.title3.weight(.semibold))
                Text("Certificate")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("May 21, 2021")
                    .font(.footnote.weight(.semibold))
                Text("Designcode instructor: Meng to")
                    .font(.footnote)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            Image("Logo 2")
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fit)
                .frame(width: 26.0, height: 26.0)
                .cornerRadius(10)
                .padding(9)
                .frostedGlassStyle(cornerRadius: 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        )
        .padding(20)
        .frostedGlassStyle(cornerRadius: 20)
        .frame(height: 220)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.linearGradient(colors: [.purple, .pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding(.horizontal, 20)
                .offset(y: -10)
        )
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.linearGradient(colors: [.cyan, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding(.horizontal, 40)
                .offset(y: -20)
        )
        .shadow(color: .clear, radius: 0, x: 0, y: 0)
        .shadow(color: Color("Shadow").opacity(0.15), radius: 30, x: 0, y: 30)
        .padding(20)
    }
}

#Preview {
    CertificateView()
}

//
//  SectionView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 07.03.2024.
//

import SwiftUI

struct SectionView: View {
    @Environment(\.dismiss) var dismiss
    var courseSection = courseSections[0]
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
            }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundStyle(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
                    .strokeStyle()
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: minY > 0 ? 500 + minY : 500)
            .background(
                PlayShape()
                    .fill(Color("Shadow"))
                    .background(
                        PlayShape()
                            .fill(.angularGradient(colors: [.red, .pink, .cyan, .yellow], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                            .blur(radius: 10)
                    )
                    .overlay(
                        PlayShape()
                            .stroke(.white)
                    )
                    .frame(width: 52, height: 52)
                    .offset(x: 5)
                    .frame(width: 120, height: 120)
                    .frostedGlassStyle(cornerRadius: 60)
                    .overlay(
                        CircleProgressView(lineWidth: 8, progress: courseSection.progress)
                    )
                    .overlay(
                        Text("12:08")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 4)
                            .background(Color(UIColor.systemBackground).opacity(0.3),
                                        in: RoundedRectangle(cornerRadius: 4, style: .continuous))
                            .offset(y: 40)
                    )
            )
            .background(
                Image(courseSection.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 500)
                    .offset(y: minY > 0 ? -minY * 0.8 : 0)
            )
            .background(
                Image(courseSection.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: minY > 0 ? -minY : 0)
                    .scaleEffect(minY > 0 ? minY / 1000 + 1 : 1)
                    .blur(radius: minY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .offset(y: -minY)
            )
            .overlay(
                overlayCover
                    .offset(y: minY > 0 ? -minY * 0.6 : 0)
            )
        }
        .frame(height: 500)
    }
    
    var overlayCover: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(courseSection.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(courseSection.subtitle)
                .font(.footnote)
                .fontWeight(.semibold)
            Text(courseSection.text)
                .font(.footnote)
            
            Divider()
            
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(9)
                    .frostedGlassStyle(cornerRadius: 20)
                Text("Taught by Meng To")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        )
        .padding(20)
        .offset(y: 250)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("SwiftUI is hands-down the best way for designers to take a first step into code. ")
                .font(.title3).fontWeight(.medium)
            Text("This course")
                .font(.title).bold()
            Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
            Text("This year, SwiftUI got major upgrades from the WWDC 2020. The big news is that thanks to Apple Silicon, Macs will be able to run iOS and iPad apps soon. SwiftUI is the only framework that allows you to build apps for all of Apple's five platforms: iOS, iPadOS, macOS, tvOS and watchOS with the same codebase. New features like the Sidebar, Lazy Grid, Matched Geometry Effect and Xcode 12's visual editing tools will make it easier than ever to build for multiple platforms.")
            Text("Multiplatform app")
                .font(.title).bold()
            Text("For the first time, you can build entire apps using SwiftUI only. In Xcode 12, you can now create multi-platform apps with minimal code changes. SwiftUI will automatically translate the navigation, fonts, forms and controls to its respective platform. For example, a sidebar will look differently on the Mac versus the iPad, while using exactly the same code. Dynamic type will adjust for the appropriate platform language, readability and information density. ")
        }
        .offset(y: 150)
        .padding(.bottom, 200)
        .padding(20)
    }
}

#Preview {
    SectionView()
}

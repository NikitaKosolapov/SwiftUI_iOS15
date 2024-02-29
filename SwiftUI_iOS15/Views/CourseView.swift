//
//  CourseView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 26.02.2024.
//

import SwiftUI
import Combine

struct CourseView: View {
    var namespace: Namespace.ID
    var course: Course = courses[0]
    @Binding var show: Bool
    @State var appear = [false, false, false]
    @EnvironmentObject var model: Model
    @State var viewState: CGSize = .zero
    @State var closeButtonOpacity: Double = 1
    @State var isDraggable = true
    @State var opacity: CGFloat = 1
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
            }
            .coordinateSpace(name: "scroll")
            .background(Color("Background"))
            
            Button {
                withAnimation(.bouncy(duration: 0.5)) {
                    show = false
                    model.showDetail = false
                    opacity = 0
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundStyle(.secondary)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
                    .strokeStyle()
            }
            .padding(20)
            .opacity(appear[2] ? 1 : 0)
            .opacity(closeButtonOpacity)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .onChange(of: show) { newValue in
                fadeOut()
            }
        }
        .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
        .scaleEffect(viewState.width / -500 + 1)
        .background(.black.opacity(viewState.width / 500))
        .background(.ultraThinMaterial)
        .opacity(opacity)
        .ignoresSafeArea()
        .simultaneousGesture (
            isDraggable ? dragGesture : nil
        )
        .onReceive(Just(viewState.width)) { _ in
            updateOpacity()
        }
        .onAppear {
            fadeIn()
            model.showDetail = true
        }
        .onDisappear {
            model.showDetail = false
        }
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
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 500)
                    .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
                    .offset(y: minY > 0 ? -minY * 0.8 : 0)
            )
            .background(
                Image(course.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
                    .offset(y: minY > 0 ? -minY : 0)
                    .scaleEffect(minY > 0 ? minY / 1000 + 1 : 1)
                    .blur(radius: minY / 10)
            )
            .mask(
                RoundedRectangle(cornerRadius: 0, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
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
            Text(course.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .matchedGeometryEffect(id: "title\(course.id)", in: namespace)
            Text(course.subtitle)
                .font(.footnote)
                .fontWeight(.semibold)
                .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)
            Text(course.text)
                .font(.footnote)
                .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
            
            Divider()
                .opacity(appear[0] ? 1 : 0)
            
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(9)
                    .frostedGlassStyle(cornerRadius: 20)
                Text("Taught by Meng To")
            }
            .opacity(appear[1] ? 1 : 0)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
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
        .offset(y: 120)
        .padding(.bottom, 200)
        .opacity(appear[2] ? 1 : 0)
        .padding(20)
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 10 {
                    withAnimation(.linear) {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded { value in
                withAnimation(.bouncy(duration: 0.5)) {
                    viewState = .zero
                }
            }
    }
    
    func fadeIn() {
        withAnimation(.easeInOut.delay(0.2)) {
            appear[0] = true
        }
        withAnimation(.easeInOut.delay(0.3)) {
            appear[1] = true
        }
        withAnimation(.easeInOut.delay(0.4)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close() {
        withAnimation(.bouncy(duration: 0.5)) {
            show = false
            model.showDetail = false
            isDraggable = false
        }
    }
    
    func updateOpacity() {
        let maxOpacityValue: Double = 1.0
        let minOpacityValue: Double = 0.0
        
        let normalizedWidth = min(1.0, max(0.0, Double(viewState.width) / 120.0))
        
        closeButtonOpacity = maxOpacityValue - normalizedWidth * (maxOpacityValue - minOpacityValue)
    }
}

struct CourseView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseView(namespace: namespace, show: .constant(true))
            .environmentObject(Model())
    }
}

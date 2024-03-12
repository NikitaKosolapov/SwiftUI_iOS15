//
//  HomeView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 25.02.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("isLiteMode") var isLiteMode = true
    @EnvironmentObject var model: Model
    @Namespace var namespace
    @State var hasScrolled: Bool = false
    @State var show: Bool = false
    @State var showStatusBar: Bool = true
    @State var selectedID = UUID()
    @State var selectedFeaturedIndex = 0
    @State var showFeaturedCourse = false
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView {
                scrollDetection
                
                featuredSection
                    .sheet(isPresented: $showFeaturedCourse, content: {
                        CourseView(namespace: namespace, course: featuredCourses[selectedFeaturedIndex], show: $showFeaturedCourse)
                    })
                
                Text("Cources".uppercased())
                    .font(.footnote.weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondary)
                    .padding(.leading, 20)
                    .padding(.bottom, 16)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                    if !show {
                        ForEach(courses) { course in
                            CourseItem(namespace: namespace, course: course)
                                .onTapGesture {
                                    withAnimation(.bouncy(duration: 0.5)) {
                                        show = true
                                        selectedID = course.id
                                        model.showDetail = true
                                    }
                                }
                        }
                    } else {
                        ForEach(courses) { course in
                            Rectangle()
                                .frame(height: 300)
                                .opacity(0)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(
                NavigationBar(hasScrolled: $hasScrolled, title: "Featured")
            )
            .onChange(of: show, perform: { value in
                withAnimation(.smooth) {
                    showStatusBar = !value
                }
            })
            .statusBarHidden(!showStatusBar)
            
            if show {
                ForEach(courses) { course in
                    if selectedID == course.id {
                        CourseView(namespace: namespace, course: course, show: $show)
                            .zIndex(1)
                            .transition(
                                .asymmetric(
                                    insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                                    removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))
                                )
                            )
                    }
                }
            }
        }
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                hasScrolled = value < 0
            }
        }
    }
    
    var featuredSection: some View {
        TabView {
            ForEach(Array(featuredCourses.enumerated()), id: \.offset) { index, course in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    FeatureItem(course: course)
                        .frame(maxWidth: 500)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 40)
                        .rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .blur(radius: abs(minX / 40))
                        .shadow(color: Color("Shadow").opacity(0.3), radius: isLiteMode ? 5 : 10, x: 0, y: 10)
                        .overlay(
                            Image(course.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 230)
                                .offset(x: 32, y: -80)
                                .offset(x: minX / 2)
                        )
                        .onTapGesture {
                            selectedFeaturedIndex = index
                            showFeaturedCourse = true
                        }
                }
            }
        }
        .dynamicTypeSize(.large ... .xxLarge)
        .background(Image("Blob 1").offset(x: 250, y: -100))
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 430)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Model())
    }
}

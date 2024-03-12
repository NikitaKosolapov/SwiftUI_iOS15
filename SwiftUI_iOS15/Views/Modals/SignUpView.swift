//
//  SignUpView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 29.02.2024.
//

import SwiftUI

struct SignUpView: View {
    enum Field: Hashable {
        case email
        case password
    }
    
    enum ViewState {
        case signIn
        case signUp
        
        var title: String {
            switch self {
            case .signIn:
                return "Sign in"
            case .signUp:
                return "Sign up"
            }
        }
        
        var endText: String {
            switch self {
            case .signIn:
                "No account yet?"
            case .signUp:
                "Already have an account?"
            }
        }
        
        var buttonTitle: String {
            switch self {
            case .signIn:
                "Sign in"
            case .signUp:
                "Create account"
            }
        }
    }
    
    @Namespace var namespace
    @State var email: String = ""
    @State var password: String = ""
    @FocusState var focusedField: Field?
    @State var state: ViewState = .signIn
    @State var translation: CGSize = .zero
    @State var isDismissed = false
    @State var appear = [false, false, false]
    @State var appearContent = [false, false, false]
    @AppStorage("showModal") var showModal: Bool = false
    @AppStorage("isLogged") var isLogged: Bool = false
    
    var body: some View {
        ZStack {
            Color.clear.background(.ultraThinMaterial)
                .ignoresSafeArea()
                .onTapGesture {
                    dismiss()
                }
            
            card
                .padding(.vertical, 20)
                .padding(.horizontal, 16)
                .coordinateSpace(name: "container")
                .frostedGlassStyle(cornerRadius: 30)
                .gesture(drag)
                .offset(translation)
                .offset(y: isDismissed ? 1000 : 0)
                .opacity(appear[0] ? 1 : 0)
                .offset(y: appear[0] ? 0 : 200)
                .rotationEffect(.degrees(translation.width / 40))
                .rotation3DEffect(.degrees(translation.height / 20), axis: (x: 1.0, y: 0.0, z: 0.0))
                .hueRotation(.degrees(translation.width / 5))
                .shadow(color: .clear, radius: 0)
                .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
                .padding(20)
                .background(
                    Image("Blob 1")
                        .offset(x: 200, y: -100)
                        .allowsHitTesting(false)
                        .opacity(appear[2] ? 1 : 0)
                        .offset(y: appear[2] ? 0 : 40)
                        .blur(radius: appear[2] ? 0 : 40)
                )
                .onAppear {
                    withAnimation(.easeOut) {
                        appear[0] = true
                    }
                    withAnimation(.easeOut.delay(0.1)) {
                        appear[1] = true
                    }
                    withAnimation(.easeOut(duration: 1).delay(0.2)) {
                        appear[2] = true
                    }
                    
                    withAnimation(.spring().delay(0.3)) {
                        appearContent[0] = true
                    }
                    withAnimation(.spring().delay(0.4)) {
                        appearContent[1] = true
                    }
                    withAnimation(.spring().delay(0.5)) {
                        appearContent[2] = true
                    }
                }
            
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
            .opacity(appear[1] ? 1 : 0)
            .offset(y: appear[1] ? 0 : -200)
        }
        .zIndex(1)
    }
    
    var card: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(state.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .transition(.scale)
                .id("title" + state.title)
                .opacity(appearContent[0] ? 1 : 0)
                .offset(y: appearContent[0] ? 0 : 20)
            
            Text("Access 120+ hours of courses, tutorials and livestreams")
                .font(.headline)
                .lineLimit(2)
                .opacity(appearContent[1] ? 1 : 0)
                .offset(y: appearContent[1] ? 0 : 20)
            
            TextField("Email address", text: $email)
                .inputStyle(icon: "envelope")
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .focused($focusedField, equals: .email)
                .shadow(color: focusedField == .email ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 4)
            
            SecureField("Password", text: $password)
                .inputStyle(icon: "key")
                .textContentType(.password)
                .focused($focusedField, equals: .password)
                .shadow(color: focusedField == .password ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 4)
            
            Button {
                isLogged = true
                dismiss()
            } label: {
                Text(state.buttonTitle)
                    .frame(maxWidth: .infinity)
            }
            .font(.headline)
            .buttonStyle(.angular)
            .tint(.accentColor)
            .controlSize(.large)
            
            if state == .signUp {
                Group {
                    Text("By clicking on *Create account*, you agree to our Terms of service ")
                    + Text("**[Terms of service](https://designcode.io)**")
                    + Text(" and ")
                    + Text("**[Privacy policy](https://designcode.io)**.")
                }
                .opacity(appearContent[2] ? 1 : 0)
                .offset(y: appearContent[2] ? 0 : 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .tint(Color.secondary)
                .foregroundStyle(.secondary)
                .font(.footnote)
                .transition(.scale)
                .id("group")
            }
            
            Divider()
            
            
            HStack(spacing: 4) {
                Text(state.endText)
                    .transition(.scale)
                    .id("endText" + state.endText)
                
                Button {
                    withAnimation {
                        state = state == .signIn ? .signUp : .signIn
                    }
                } label: {
                    Text("**\(state.title)**")
                        .transition(.scale)
                        .id("label" + state.title)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .foregroundStyle(.secondary)
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.snappy) {
                    translation = value.translation
                }
            }
            .onEnded { value in
                if value.translation.height > 200 {
                    dismiss()
                } else {
                    translation = .zero
                }
            }
    }
    
    func dismiss() {
        withAnimation {
            isDismissed = true
        }
        
        withAnimation(.linear.delay(1)) {
            showModal = false
        }
    }
}

#Preview {
    ZStack {
        SignUpView()
            .preferredColorScheme(.light)
    }
}

//
//  AccountView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 23.02.2024.
//

import SwiftUI

struct AccountView: View {
    @State var isDeleted: Bool = false
    @State var isPinned: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
                
                links
            }
            .foregroundColor(.primary)
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    var profile: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    HexagonView()
                        .offset(x: -50, y: -100)
                )
                .background(
                    BlobView()
                        .offset(x: 200, y: -70)
                        .scaleEffect(0.6)
                )
            Text("Nikita")
                .font(.title.weight(.semibold))
            HStack {
                Image(systemName: "location")
                    .imageScale(.medium)
                Text("Thailand")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity) // use maxWidth: .infinity instead of HStack
    }
    
    var menu: some View {
        Section {
            NavigationLink(destination: HomeView()) {
                Label("Settings", systemImage: "gear")
            }
            NavigationLink {
                Text("Billing")
            } label: {
                Label("Billing", systemImage: "creditcard")
            }
            NavigationLink {
                HomeView()
            } label: {
                Label("Help", systemImage: "questionmark")
            }
        }
        .listRowSeparator(.hidden)
    }
    
    var links: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: "https://apple.com")!, label: {
                    HStack {
                        Label("Website", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                })
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button {
                        isDeleted = true
                    } label: {
                        Label("remove", systemImage: "trash")
                    }
                    .tint(.red)
                    
                    pinButton
                }
            }
            Link(destination: URL(string: "https://youtube.com")!, label: {
                HStack {
                    Label("Youtube", systemImage: "tv")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            })
        }
        .listRowSeparator(.hidden)
    }
    
    var pinButton: some View {
        Button {
            isPinned.toggle()
        } label: {
            Label("pin", systemImage: isPinned ? "pin" : "pin.slash")
        }
        .tint(isPinned ? .yellow : .gray)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

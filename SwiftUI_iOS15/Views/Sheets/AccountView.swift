//
//  AccountView.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 23.02.2024.
//

import SwiftUI

struct AccountView: View {
    @AppStorage("isLiteMode") var isLiteMode = true
    @AppStorage("isLogged") var isLogged = true
    @State var isDeleted: Bool = false
    @State var isPinned: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var address = Address(id: 1, country: "Thailand")
    @StateObject var coinModel = CoinModel()
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
                
                liteMode
                
                links
                
                if !coinModel.coins.isEmpty {
                    coins
                }
                
                signOut
            }
            .task {
                await fetchData()
                await coinModel.fetchCoins()
            }
            .refreshable {
                await fetchData()
                await coinModel.fetchCoins()
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
                Text(address.country)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
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
    
    var liteMode: some View {
        Section {
            Toggle(isOn: $isLiteMode) {
                Label("Lite mode", systemImage: isLiteMode ? "tortoise" : "hare")
            }
        }
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
    
    var coins: some View {
        Section {
            ForEach(coinModel.coins) { coin in
                HStack {
                    AsyncImage(url: URL(string: coin.logo)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 32, height: 32)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coin.coinName)
                        Text(coin.acronym)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        } header: {
            Text("Coins")
        }
    }
    
    var pinButton: some View {
        Button {
            isPinned.toggle()
        } label: {
            Label("pin", systemImage: isPinned ? "pin" : "pin.slash")
        }
        .tint(isPinned ? .yellow : .gray)
    }
    
    var signOut: some View {
        Button {
            isLogged = false
            dismiss()
        } label: {
            Text("Sign out")
                .foregroundStyle(.red)
        }
    }
    
    func fetchData() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/v2/addresses")!
            let (data, _) = try await URLSession.shared.data(from: url)
            address = try JSONDecoder().decode(Address.self, from: data)
        } catch {
            address = Address(id: 1, country: "Error fetching")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

//
//  Coin.swift
//  SwiftUI_iOS15
//
//  Created by Nikita Kosolapov on 07.03.2024.
//

import SwiftUI

struct Coin: Identifiable, Decodable {
    let id: Int
    let coinName: String
    let acronym: String
    let logo: String
}

class CoinModel: ObservableObject {
    @Published var coins: [Coin] = []
    
    @MainActor
    func fetchCoins() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/crypto_coin/random_crypto_coin?size=10")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            coins = try decoder.decode([Coin].self, from: data)
        } catch {
            print(#function)
        }
    }
}

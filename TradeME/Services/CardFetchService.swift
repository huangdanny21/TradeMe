//
//  CardFetchService.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

struct CardFetchService {
    static func cardPrice(for name: String) async throws -> CardResponseContainer {
        let url = APIS.CardPrice.cardName(name: name).url
        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, _) = try await URLSession.shared.data(from: url)
        // Parse the JSON data
        let card = try JSONDecoder().decode(CardResponseContainer.self, from: data)
        return card
    }
    
    static func cardData(for name: String) async throws -> YGOCardWrapper {
        let url = APIS.CardData.name(name: name).url
        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, _) = try await URLSession.shared.data(from: url)
        // Parse the JSON data
        let card = try JSONDecoder().decode(YGOCardWrapper.self, from: data)
        return card
    }
    
    static func cardImage(for set: String) async throws -> YGOCardWrapper {
        let url = APIS.CardImage.cardSet(set: set).url
        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, _) = try await URLSession.shared.data(from: url)
        // Parse the JSON data
        let card = try JSONDecoder().decode(YGOCardWrapper.self, from: data)
        return card
    }
}

//
//  CardResponseContainer.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

struct CardPrices: Codable {
    let high: Double
    let low: Double
    let average: Double
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case high = "high"
        case low = "low"
        case average = "average"
        case updatedAt = "updated_at"
    }
}

struct PriceContainer: Codable {
    let listings: [String]
    let prices: CardPrices
    
    enum CodingKeys: String, CodingKey {
        case listings = "listings"
        case prices = "prices"
    }
}

struct PriceData: Codable {
    let status: Bool
    let data: PriceContainer
}

struct BasicCard: Codable {
    let name: String
    let printTag: String
    let rarity: String
    let priceData: PriceData
    
    enum CodingKeys: String, CodingKey {
        case name
        case printTag = "print_tag"
        case rarity
        case priceData = "price_data"
    }
}

struct CardResponseContainer: Codable {
    let status: String
    let data: BasicCard
}

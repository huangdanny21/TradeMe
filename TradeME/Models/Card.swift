//
//  CardResponseContainer.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

struct CardResponseContainer: Codable {
    let status: Status
    let data: [BasicCard]
}

struct BasicCard: Identifiable, Codable {
    let name, printTag, rarity: String
    let priceData: PriceData
    let id = UUID().uuidString
    
    enum CodingKeys: String, CodingKey {
        case name
        case printTag = "print_tag"
        case rarity
        case priceData = "price_data"
    }
}

struct PriceData: Codable {
    let status: Status
    let data: DataClass?
    let message: String?
}

struct DataClass: Codable {
    let listings: [String]
    let prices: Prices
}

struct Prices: Codable {
    let high, low, average, shift: Double
    let shift3, shift7, shift21, shift30: Double
    let shift90, shift180, shift365: Double
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case high, low, average, shift
        case shift3 = "shift_3"
        case shift7 = "shift_7"
        case shift21 = "shift_21"
        case shift30 = "shift_30"
        case shift90 = "shift_90"
        case shift180 = "shift_180"
        case shift365 = "shift_365"
        case updatedAt = "updated_at"
    }
}

enum Status: String, Codable {
    case fail = "fail"
    case success = "success"
}

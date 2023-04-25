//
//  Card.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import Foundation

// This Card for price/Transaction history
struct Card: Identifiable, Codable {
    var id: UUID
    var name: String
    var cardSet: String
    var imageUrl: String
    var rarity: String
    var price: Double
}


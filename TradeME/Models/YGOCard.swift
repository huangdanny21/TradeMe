//
//  YGOCard.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

protocol Card {
    
}

struct YGOCardWrapper: Codable {
    let status: String
    let data: YGOCard
}

struct YGOCard: Card, Codable {
    let name, text, cardType, type: String
    let family: String
    let atk, def, level: Int
    let property: String?

    enum CodingKeys: String, CodingKey {
        case name, text
        case cardType = "card_type"
        case type, family, atk, def, level, property
    }
}

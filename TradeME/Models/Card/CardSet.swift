//
//  CardSet.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import Foundation

struct CardSet: Identifiable, Codable {
    var id: UUID
    var name: String
    var description: String
    var imageUrl: String
    var price: Double
}


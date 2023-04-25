//
//  FSCard.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct FSCard: Codable, Identifiable {
    var id: String?
    let name: String
    let tag: String
    let rarity: String
    let price: Double
    
    func toFirestore() -> [String: Any] {
         ["name": name,
          "tag": tag,
          "rarity": rarity,
          "price": price]
    }
}

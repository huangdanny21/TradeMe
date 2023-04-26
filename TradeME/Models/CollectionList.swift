//
//  ColllectionList.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation
import FirebaseFirestore

struct FSCollectionListContainer: Codable, Identifiable {
    var id: String?
    var userId: String
    var collections: [FSCollectionList]
}

struct FSCollectionList: Codable, Identifiable {
    var id = UUID().uuidString
    var userId: String?
    var title: String
    let description: String
    let cards: [FSCard]

    enum CodingKeys: String, CodingKey {
        case userId
        case title
        case description
        case cards
    }

    init(id: String? = nil, title: String, description: String, cards: [FSCard]) {
        self.userId = id
        self.title = title
        self.description = description
        self.cards = cards
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        self.cards = try container.decodeIfPresent([FSCard].self, forKey: .cards) ?? []
    }
}



extension FSCollectionList {
    func toDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["startDate"] = Date().timeIntervalSince1970
        dict["title"] = title
        dict["description"] = description
        
        var cardsDict: [[String: Any]] = []
        for card in cards {
            cardsDict.append(card.toFirestore())
        }
        dict["cards"] = cardsDict
        
        return dict
    }
}

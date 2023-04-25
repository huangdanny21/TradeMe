//
//  ColllectionList.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation
import FirebaseFirestore

struct CollectionList: Identifiable, Codable {
    let title: String
    let descrption: String
    var cards: [BasicCard]
    var id: String?
    var count = 0
}

extension BasicCard {
    func toFSCard() -> FSCard {
        FSCard(name: name, tag: printTag, rarity: rarity, price: priceData.data?.prices.average ?? 0)
    }
}

struct FSCollectionList: Codable, Identifiable {
    var id: String?
    let title: String
    let descrpition: String
    let cards: [FSCard]
}

extension FSCollectionList {
    func toDict() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["startDate"] = FieldValue.serverTimestamp()
        dict["title"] = title
        dict["description"] = descrpition
        
        var cardsDict: [[String: Any]] = []
        for card in cards {
            cardsDict.append(card.toFirestore())
        }
        dict["cards"] = cardsDict
        
        return dict
    }
}


extension CollectionList {
    func toFirestoreOject() -> FSCollectionList {
        FSCollectionList(title: title, descrpition: descrption, cards: cards.map{$0.toFSCard()})
    }
}

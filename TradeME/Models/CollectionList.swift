//
//  ColllectionList.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

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

struct FSCollectionList: Codable {
    let title: String
    let descrpition: String
    let cards: [FSCard]
}

extension CollectionList {
    func toFirestoreOject() -> FSCollectionList {
        FSCollectionList(title: title, descrpition: descrption, cards: cards.map{$0.toFSCard()})
    }
}

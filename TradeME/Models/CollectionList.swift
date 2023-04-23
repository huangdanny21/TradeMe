//
//  ColllectionList.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

struct CollectionListHashable: Identifiable, Codable {
    let key: String
    let collection: CollectionList
    var id = UUID()
}

struct CollectionList: Identifiable, Codable {
    let title: String
    let descrption: String
    var cards: [BasicCard]
    var id = UUID().uuidString
    var count = 0
}

struct FSCard: Codable {
    let name: String
    let tag: String
    let rarity: String
}

extension BasicCard {
    func toFSCard() -> FSCard {
        FSCard(name: name, tag: printTag, rarity: rarity)
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

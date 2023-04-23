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
    let descrption: String?
    var cards: [BasicCard]
    var id = UUID()
    var count = 0
}

//
//  ColllectionList.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import Foundation

struct CollectionList: Identifiable {
    let title: String
    let descrption: String?
    let cards: [YGOCard]
    let id = UUID()
}

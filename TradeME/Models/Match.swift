//
//  Match.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import Foundation

struct Match: Codable, Hashable {
    var player1: String
    var player2: String
    var result: String? // or another type to represent the match result
}

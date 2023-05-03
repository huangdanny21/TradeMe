//
//  Match.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import Foundation

struct Match: Codable, Identifiable, Hashable {
    var id: String?
    var player1: Player
    var player2: Player
    var result: String? // or another type to represent the match result
    var winner: Player? // add a winner property to the match
    var roundNumber: Int
    
    func toDict() -> [String: Any] {
        ["player1": player1.toDict(),
         "player2": player2.toDict(),
         "result": result ?? "",
         "winner": winner?.toDict() ?? [:],
         "roundNumber": roundNumber
        ]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(player1)
        hasher.combine(player2)
        hasher.combine(result)
        hasher.combine(winner)
        hasher.combine(roundNumber)
    }
}

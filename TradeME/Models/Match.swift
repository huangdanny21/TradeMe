//
//  Match.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import Foundation

struct Match: Codable, Identifiable {
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
}

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
    var winner: String?
}

//func generateBracket(players: [String]) -> [Match] {
//    var matches = [Match]()
//    let numPlayers = players.count
//    
//    // If there are an odd number of players, add a bye round
//    if numPlayers % 2 == 1 {
//        matches.append(Match(player1: "BYE", player2: players[0], winner: players[0]))
//    }
//    
//    // Generate the first round of matches
//    for i in stride(from: 0, to: numPlayers, by: 2) {
//        matches.append(Match(player1: players[i], player2: players[i+1], winner: nil))
//    }
//    
//    return matches
//}

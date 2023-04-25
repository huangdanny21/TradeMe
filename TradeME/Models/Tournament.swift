//
//  Tournament.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Tournament: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var rounds: [Round]
    var numberOfPlayers: Int
    var entryFee: Double
    var prizeMoney: Double
    var startDate: Date
    var players: [Player]
    
    // convert the tournament object to a dictionary
    func toDict() -> [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDateString = dateFormatter.string(from: startDate)
        
        let playerDicts = players.map { $0.toDict() }
        
        return [
            "name": name,
            "numberOfPlayers": numberOfPlayers,
            "entryFee": entryFee,
            "prizeMoney": prizeMoney,
            "startDate": startDateString,
            "rounds": rounds,
            "players": playerDicts
        ]
    }
    
    // add a new player to the tournament
    mutating func addPlayer(_ player: Player) {
        players.append(player)
    }
}


struct Round: Codable, Identifiable {
    @DocumentID var id: String?
    var number: Int
    var date: Date
    var matches: [Match]
    var players: [String] // UserId
}

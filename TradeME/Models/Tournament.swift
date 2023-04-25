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
    var createdBy: String
    var started: Bool
    var ended: Bool
    var imageUrl: String? {
        "tournaments/\(name).jpg"
    }
    
    // convert the tournament object to a dictionary
    func toDict() -> [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let startDateString = dateFormatter.string(from: startDate)
        
        let playerDicts = players.map { $0.toDict() }
        let roundDicts = rounds.map { $0.toDict() }
        
        var dict: [String: Any] = ["name": name,
                    "numberOfPlayers": numberOfPlayers,
                    "entryFee": entryFee,
                    "prizeMoney": prizeMoney,
                    "startDate": startDateString,
                    "players": playerDicts,
                    "rounds": roundDicts,
                    "started": started,
                    "ended": ended];
        if let imageUrlString = imageUrl {
            dict["imageUrl"] = imageUrlString
        }
        return dict
    }
    
    // add a new player to the tournament
    mutating func addPlayer(_ player: Player) {
        players.append(player)
    }
}

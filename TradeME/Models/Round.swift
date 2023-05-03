//
//  Round.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

struct Round: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var number: Int
    var date: Date
    var matches: [Match]
    var players: [Player] // UserId
    var inProgress: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(number)
        hasher.combine(date)
        hasher.combine(matches)
        hasher.combine(players)
        hasher.combine(inProgress)
    }
    
    // convert the round object to a dictionary
    func toDict() -> [String: Any] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        let matchDicts = matches.map { $0.toDict() }
        let playerDicts = players.map { $0.toDict() }
        
        return ["number": number,
                "date": dateString,
                "matches": matchDicts,
                "players": playerDicts,
                "inProgress": inProgress]
    }
}


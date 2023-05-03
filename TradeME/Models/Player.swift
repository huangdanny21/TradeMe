//
//  Player.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import FirebaseFirestoreSwift

struct Player: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var phoneNumber: String
    
    // convert the player object to a dictionary
    func toDict() -> [String: Any] {
        ["name": name,
        "email": email,
        "phoneNumber": phoneNumber]
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}

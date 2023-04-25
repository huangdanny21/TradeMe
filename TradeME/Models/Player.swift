//
//  Player.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import FirebaseFirestoreSwift

struct Player: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var phoneNumber: String
    
    // convert the player object to a dictionary
    func toDict() -> [String: Any] {
        return [            "name": name,            "email": email,            "phoneNumber": phoneNumber        ]
    }
}

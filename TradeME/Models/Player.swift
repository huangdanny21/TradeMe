//
//  Player.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import Foundation

struct Player: Codable {
    let name: String
    let email: String
    let phoneNumber: String
    
    // convert the player object to a dictionary
    func toDict() -> [String: Any] {
        return [
            "name": name,
            "email": email,
            "phoneNumber": phoneNumber
        ]
    }
}

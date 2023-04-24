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
}

struct Round: Codable, Identifiable {
    @DocumentID var id: String?
    var number: Int
    var date: Date
    var players: [String] // UserId
}

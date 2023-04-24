//
//  StoreCredit.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import Firebase

struct StoreCredit: Codable {
    let userID: String
    var balance: Double
    
    init(userID: String, balance: Double) {
        self.userID = userID
        self.balance = balance
    }
    
    // Convenience initializer to create a StoreCredit from a Firestore document
    init?(document: QueryDocumentSnapshot) {
        guard let balance = document.data()["balance"] as? Double
        else {
            return nil
        }
        let userID = document.documentID
        self.userID = userID
        self.balance = balance
    }
    
    // Returns a dictionary representation of the StoreCredit object, for saving to Firestore
    func toDict() -> [String: Any] {
        return [
            "balance": balance
        ]
    }
}

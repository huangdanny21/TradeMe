//
//  Transaction.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import FirebaseFirestoreSwift
import FirebaseFirestore

struct Transaction: Codable, Identifiable {
    @DocumentID var id: String?
    var amount: Double
    var type: String
    var timestamp: Date
}

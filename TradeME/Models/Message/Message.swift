//
//  Message.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation

struct Message: Codable, Identifiable {
    var id: String?
    var senderId: String?
    var receiverId: String?
    var content: String
    var timestamp: Date
}

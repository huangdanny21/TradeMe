//
//  Conversation.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation

struct Conversation: Identifiable, Codable {
    let id: String
    let recipientId: String
    let lastMessage: String
    let timeStamp: Date
}

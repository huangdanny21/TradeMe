//
//  MessageListViewModel.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation
import FirebaseFirestore

class MessageListViewModel: ObservableObject {
    @Published var conversations = [Conversation]()
    private var db = Firestore.firestore()
    private var currentUserID: String?
    
    init(currentUserID: String?) {
        self.currentUserID = currentUserID
        fetchConversations()
    }
    
    private func fetchConversations() {
        guard let currentUserID = currentUserID else {
            return
        }
        
        db.collection("conversations")
            .whereField("participants", arrayContains: currentUserID)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Error fetching conversations: \(error!)")
                    return
                }
                
                self.conversations = documents.compactMap { queryDocumentSnapshot -> Conversation? in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    guard let recipientId = data["recipientId"] as? String,
                          let lastMessage = data["lastMessage"] as? String,
                          let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() else {
                        print("Error parsing conversation data")
                        return nil
                    }
                    
                    let conversation = Conversation(id: id, recipientId: recipientId, lastMessage: lastMessage, timeStamp: timestamp)
                    return conversation
                }
            }
    }
}

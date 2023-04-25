//
//  ChatViewModel.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation
import Firebase

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    private var listenerRegistration: ListenerRegistration?
    
    init(senderId: String, receiverId: String) {
        let db = Firestore.firestore()
        let collection = db.collection("messages")
        
        let query = collection
            .whereField("senderId", in: [senderId, receiverId])
            .whereField("receiverId", in: [senderId, receiverId])
            .order(by: "timestamp")
        
        listenerRegistration = query.addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            self.messages = documents.compactMap { queryDocumentSnapshot -> Message? in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                guard let senderId = data["senderId"] as? String,
                      let receiverId = data["receiverId"] as? String,
                      let content = data["content"] as? String,
                      let timestamp = (data["timestamp"] as? Timestamp)?.dateValue() else {
                    print("Error parsing message data")
                    return nil
                }
                
                let message = Message(id: id, senderId: senderId, receiverId: receiverId, content: content, timestamp: timestamp)
                return message
            }
        }
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    func sendMessage(senderId: String, receiverId: String, content: String) {
        let db = Firestore.firestore()
        let collection = db.collection("messages")
        let message = Message(senderId: senderId, receiverId: receiverId, content: content, timestamp: Date())
        do {
            _ = try collection.addDocument(from: message)
        } catch {
            print("Error sending message: \(error)")
        }
    }
}


//
//  MessageListView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import SwiftUI

struct MessageListView: View {
    @ObservedObject var viewModel: MessageListViewModel
    let recipientId: String
    
    var body: some View {
        List(viewModel.conversations) { conversation in
            let ChatView = ChatView(viewModel: ChatViewModel(senderId: conversation.id, receiverId: conversation.recipientId), senderId: conversation.id, receiverId: conversation.recipientId)
            NavigationLink(destination: ChatView, label: {
                VStack(alignment: .leading) {
                    Text(conversation.recipientId)
                        .font(.headline)
                    Text(conversation.lastMessage)
                        .font(.subheadline)
                    Text(conversation.timeStamp, style: .relative)
                        .font(.caption)
                }
            })
        }
        .navigationTitle("Messages")
        .onAppear {
//            viewModel = MessageListViewModel(currentUserID: Auth.auth().currentUser?.uid)
        }
    }
}


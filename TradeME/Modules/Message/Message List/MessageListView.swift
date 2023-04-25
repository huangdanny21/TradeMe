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
    @State private var showUserSearch = false
    @State private var selectedUser: FSUser?
    
    var body: some View {
        NavigationView {
            VStack {
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
            }
            .navigationTitle("Messages")
            // System add button in the top-right corner
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showUserSearch = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
        .sheet(isPresented: $showUserSearch, content: {
            UserSearchView(onUserSelected: { user in
                selectedUser = user
            })
        })
        .padding()
    }
}



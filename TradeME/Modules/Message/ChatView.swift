//
//  ChatView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    let senderId: String
    let receiverId: String
    
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                if message.senderId == senderId {
                    HStack {
                        Spacer()
                        Text(message.content)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    HStack {
                        Text(message.content)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        Spacer()
                    }
                }
            }
            
            HStack {
                TextField("Message", text: $messageText)
                    .padding(.horizontal, 10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding()
        }
        .navigationTitle("Chat with \(receiverId)")
        .onAppear {
//            viewModel = ChatViewModel(senderId: senderId, receiverId: receiverId)
        }
    }
    
    private func sendMessage() {
        viewModel.sendMessage(senderId: senderId, receiverId: receiverId, content: messageText)
        messageText = ""
    }
}

//
//  MessageView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import SwiftUI

struct MessageView: View {
    var messages: [String] = ["Hello!", "How are you?", "What's up?"]
    
    var body: some View {
        VStack {
            List(messages, id: \.self) { message in
                Text(message)
            }
        }
        .navigationTitle("Messages")
    }
}


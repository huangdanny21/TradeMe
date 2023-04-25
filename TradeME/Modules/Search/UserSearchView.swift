//
//  UserSearchView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct UserSearchView: View {
    @State private var searchText = ""
    @State private var users: [FSUser] = []
    
    var onUserSelected: ((FSUser) -> Void)
    
    var body: some View {
        VStack {
            TextField("Search Users", text: $searchText)
                .padding()
                .onChange(of: searchText, perform: { _ in
                    searchUsers()
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            List(users) { user in
                HStack {
                    Text(user.id)
                    Spacer()
                    Button(action: {
                        onUserSelected(user)
                    }, label: {
                        Text("Message")
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                }
            }
        }
        .navigationTitle("Search Users")
    }
    
    private func searchUsers() {
        // code to search for users in Firestore and update users property
    }
}

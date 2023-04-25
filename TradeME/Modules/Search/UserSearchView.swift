//
//  UserSearchView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

struct UserSearchView: View {
    @State private var searchText = ""
    @State private var users: [FSUser] = []
    
    var onUserSelected: ((FSUser) -> Void)
    
    init(onUserSelected: @escaping (FSUser) -> Void) {
        self.onUserSelected = onUserSelected
        self._users = State(initialValue: [])
        searchUsers()
    }
    
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
        let db = Firestore.firestore()
        db.collection("users")
            .whereField("id", isGreaterThan: searchText)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error searching for users: \(error.localizedDescription)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }
                let users = documents.compactMap { queryDocumentSnapshot -> FSUser? in
                    return try? queryDocumentSnapshot.data(as: FSUser.self)
                }
                self.users = users
            }
    }

}

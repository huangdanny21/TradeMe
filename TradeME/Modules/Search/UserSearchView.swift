//
//  UserSearchView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/25/23.
//

import SwiftUI
import FirebaseFirestore
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
        // Use lowercase string for case-insensitive search
        let searchText = self.searchText.lowercased()
        
        Firestore.firestore().collection("users")
            .whereField("username", isGreaterThanOrEqualTo: searchText)
            .whereField("username", isLessThan: searchText + "{")
            .getDocuments { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                // Create an array of FSUser instances from the query results
                let users = documents.compactMap { document -> FSUser? in
                    let data = document.data()
                    let id = document.documentID
                    let username = data["username"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let konamiId = data["konamiId"] as? String ?? ""
                    let user = FSUser(id: id, firstName: nil, lastName: nil, email: email, konamiId: konamiId, userName: username)
                    return user
                }
                
                // Filter users by konamiId, username, or email
                let filteredUsers = users.filter { user in
                    let lowercaseSearchText = searchText.lowercased()
                    let lowercaseUsername = user.userName?.lowercased() ?? ""
                    let lowercaseEmail = user.email.lowercased()
                    let lowercaseKonamiId = user.konamiId?.lowercased() ?? ""
                    return lowercaseUsername.contains(lowercaseSearchText) || lowercaseEmail.contains(lowercaseSearchText) || lowercaseKonamiId.contains(lowercaseSearchText)
                }
                
                self.users = filteredUsers
            }
    }
}


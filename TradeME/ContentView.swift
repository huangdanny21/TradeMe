//
//  ContentView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/18/23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var isLoggedIn = false
    @State var currentText = ""
    
    var body: some View {
        TabView {
            CollectionListView(collections: [])
                .tabItem {
                    Image(systemName: "rectangle.stack")
                    Text("Collection")
                }
            
            CardSearchView(addCard: { model in
                
            })
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            TournamentListView()
                .tabItem {
                    Image(systemName: "trophy")
                    Text("Tournament")
                }

            MessageListView(viewModel: MessageListViewModel(currentUserID: Auth.auth().currentUser?.uid), recipientId: "")
                .tabItem {
                    Image(systemName: "message")
                    Text("Message")
                }
            
            ProfileContainerView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .environmentObject(SessionStore())
        }
        .onAppear {
            checkLoginStatus()
        }
    }
    
    private func checkLoginStatus() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                // User is logged in, show EditProfileView
                isLoggedIn = true
            } else {
                // User is not logged in, show login screen
                isLoggedIn = false
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

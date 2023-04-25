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
            
            MessageView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Message")
                }
            
            if isLoggedIn {
                EditProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            } else {
                LoginView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Login")
                    }
            }
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

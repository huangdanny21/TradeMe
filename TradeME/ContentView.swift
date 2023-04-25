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
        NavigationView {
            Form {
                Section {
                    VStack {
                        if isLoggedIn {
                            NavigationLink(destination: EditProfileView()) {
                                Text("Edit Profile")
                            }
                        } else {
                            NavigationLink(destination: LoginView()) {
                                Text("Login")
                            }
                            NavigationLink(destination: SignUpView()) {
                                Text("Sign Up")
                            }
                        }
                    }
                    .padding(.top, 5) // Add padding to the top
                }

                Section {
                    NavigationLink(destination: CollectionListView(collections: [])) {
                        Text("My Collections")
                    }
                    NavigationLink(destination: TournamentListView()) {
                        Text("Tournament List")
                    }
                }
            }
            .padding()
            .navigationTitle("Home")
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

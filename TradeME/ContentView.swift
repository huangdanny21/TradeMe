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
            VStack {
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                }
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                }
                if isLoggedIn {
                    NavigationLink(destination: EditProfileView()) {
                        Text("Edit Profile")
                    }
                }
                NavigationLink(destination: CollectionListView(collections: [])) {
                     Text("My Collections")
                 }
            }
            .padding()
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

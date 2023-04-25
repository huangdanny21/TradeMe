//
//  AuthViewModel.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/22/23.
//


import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var error: AuthError? = nil
    
    private var auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func signUp() {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.error = AuthError(message: error.localizedDescription)
            } else {
                // Create a new user document in Firestore
                let user =  FSUser(id: authResult!.user.uid, email: self.email)
                do {
                    try self.db.collection("users").document(authResult!.user.uid).setData(from: user)
                } catch let error {
                    print("Error creating user document: \(error)")
                }
                
                print("User created successfully")
            }
        }
    }
}


struct AuthError: Error, Identifiable {
    let id = UUID()
    var message: String
}

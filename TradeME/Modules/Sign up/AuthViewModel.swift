//
//  AuthViewModel.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/22/23.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var error: AuthError? = nil

  private var auth = Auth.auth()

  func signUp() {
    auth.createUser(withEmail: email, password: password) { authResult, error in
      if let error = error {
        self.error = AuthError(message: error.localizedDescription)
          if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
          } else {
            // No user is signed in.
            // ...
          }
      } else {
        print("User created successfully")
      }
    }
  }
}

struct AuthError: Error, Identifiable {
  let id = UUID()
  var message: String
}

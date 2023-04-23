//
//  SignUpView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/22/23.
//

import SwiftUI

struct SignUpView: View {
  @ObservedObject var viewModel = AuthViewModel()
  
  struct Error: Identifiable {
    var id = UUID()
    var message: String
  }
  
  var body: some View {
      Form {
          Section {
            TextField("Email", text: $viewModel.email)
              .autocapitalization(.none)
              .keyboardType(.emailAddress)
            SecureField("Password", text: $viewModel.password)
          }
          
          Section {
            Button("Sign Up") {
              viewModel.signUp()
            }
          }
      }
    .alert(item: $viewModel.error) { error in
      Alert(title: Text("Error"), message: Text(error.message))
    }
  }
}

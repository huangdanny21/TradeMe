//
//  LoginView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/22/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject var session: SessionStore
    @State var email: String = ""
    @State var password: String = ""
    @State var isCreatingAccount = false
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(isCreatingAccount ? "Create Account" : "Login")
                    .font(.largeTitle)
                    .bold()
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                Button(action: {
                    if isCreatingAccount {
                        session.signUp(email: email, password: password) { result in
                            handleAuthResult(error: result)
                        }
                    } else {
                        session.signIn(email: email, password: password) { result in
                            handleAuthResult(error: result)
                        }
                    }
                }) {
                    Text(isCreatingAccount ? "Create Account" : "Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                if isCreatingAccount {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    Button("Login") {
                        isCreatingAccount = false
                    }
                    .foregroundColor(.blue)
                } else {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    Button("Create Account") {
                        isCreatingAccount = true
                    }
                    .foregroundColor(.blue)
                }
            }
            .padding()
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Error"), message: Text(session.error?.localizedDescription ?? "Unknown Error"), dismissButton: .default(Text("OK")))
            }
            .navigationTitle("TradeME")
        }
    }
    func handleAuthResult(error: Error?) {
        if let error = error {
            // Show error message
            session.error = error
            isShowingAlert = true
        } else {
            // Successful login or account creation
            isShowingAlert = false
            email = ""
            password = ""
            // Navigate to EditProfileView
            if let uid = Auth.auth().currentUser?.uid {
                let editProfileView = EditProfileView(userId: uid)
                let hostingController = UIHostingController(rootView: editProfileView)
                DispatchQueue.main.async {
                    UIApplication.shared.windows.first?.rootViewController = hostingController
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
        }
    }


}


//
//  EditProfileView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import Firebase

struct EditProfileView: View {
    @State private var email = ""
    @State private var konamiId = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Konami ID", text: $konamiId)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Button(action: {
                saveProfileData()
            }, label: {
                Text("Save Changes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            })
        }
        .navigationBarTitle("Edit Profile")
    }
    
    private func saveProfileData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            // User is not signed in, cannot save profile data
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)
        
        userRef.updateData([
            "email": email,
            "konamiId": konamiId
        ]) { error in
            if let error = error {
                print("Error updating user document: \(error.localizedDescription)")
            } else {
                print("User document updated successfully!")
            }
        }
    }
}

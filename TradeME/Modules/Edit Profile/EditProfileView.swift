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
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Email", text: $email)
                TextField("Konami ID", text: $konamiId)
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
        }
        .navigationBarTitle("Edit Profile")
        .onAppear {
            // Retrieve user data from Firestore
            let db = Firestore.firestore()
            let currentUser = Auth.auth().currentUser
            
            db.collection("users").document(currentUser!.uid).getDocument { (snapshot, error) in
                if let error = error {
                    print("Error fetching user data: \(error.localizedDescription)")
                    return
                }
                
                if let snapshot = snapshot {
                    let data = snapshot.data()
                    if let email = data?["email"] as? String {
                        self.email = email
                    }
                    if let konamiId = data?["konamiId"] as? String {
                        self.konamiId = konamiId
                    }
                }
            }
        }
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

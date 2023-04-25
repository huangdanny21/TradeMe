//
//  EditProfileView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var konamiId: String = ""
    @State var userName: String = ""
    
    let userId: String
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
            }
            
            Section(header: Text("Account Information")) {
                TextField("Email", text: $email)
                TextField("Username", text: $userName)
            }
            
            Section(header: Text("Konami Information")) {
                TextField("Konami ID", text: $konamiId)
            }
            
            Button("Save Changes") {
                saveChanges()
            }
        }
        .navigationTitle("Edit Profile")

        .padding()
        .onAppear(perform: fetchUserData)
    }
    
    func fetchUserData() {
        fetchUser(withId: userId) { (user, error) in
            if let user = user {
                firstName = user.firstName ?? ""
                lastName = user.lastName ?? ""
                email = user.email
                konamiId = user.konamiId ?? ""
                userName = user.userName ?? ""
            } else if let error = error {
                // handle the error
            } else {
                // handle the case where the document doesn't exist
            }
        }
    }
    
    func fetchUser(withId id: String, completion: @escaping (FSUser?, Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(id)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                do {
                    let user = try document.data(as: FSUser.self)
                    completion(user, nil)
                } catch {
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    func saveChanges() {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userId)
        
        userRef.updateData([
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "konamiId": konamiId,
            "userName": userName
        ]) { error in
            if let error = error {
                print("Error updating user: \(error)")
            } else {
                print("User updated successfully!")
            }
        }
    }
}


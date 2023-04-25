//
//  EditProfileView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import Firebase
import PopupView

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var session: SessionStore
    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String
    @State private var konamiId: String
    @State private var userName: String

    init(session: SessionStore) {
        self.session = session
        if let user = session.user {
            self._firstName = State(wrappedValue: user.firstName ?? "")
            self._lastName = State(wrappedValue: user.lastName ?? "")
            self._email = State(wrappedValue: user.email)
            self._konamiId = State(wrappedValue: user.konamiId ?? "")
            self._userName = State(wrappedValue: user.userName ?? "")
        } else {
            self._firstName = State(wrappedValue: "")
            self._lastName = State(wrappedValue: "")
            self._email = State(wrappedValue: "")
            self._konamiId = State(wrappedValue: "")
            self._userName = State(wrappedValue: "")
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("PERSONAL INFO")) {
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                    TextField("Email", text: $email)
                }
                Section(header: Text("OTHER INFO")) {
                    TextField("Konami ID", text: $konamiId)
                    TextField("Username", text: $userName)
                }
                Button(action: save) {
                    Text("Save")
                }
                .buttonStyle(RoundedButtonStyle())
                .padding(.top, 20)
                .accentColor(.green)
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: dismiss) {
                Text("Cancel")
            })
        }
    }

    private func save() {
        let updatedUser = FSUser(id: session.user!.id,
                                 firstName: firstName,
                                 lastName: lastName,
                                 email: email,
                                 konamiId: konamiId,
                                 userName: userName)
        
        session.updateUser(updatedUser) { error in
            if let error = error {
                print("Error updating user: \(error.localizedDescription)")
            } else {
                dismiss()
            }
        }
    }


    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

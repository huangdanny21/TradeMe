//
//  TournamentSignUpView.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/24/23.
//

import SwiftUI
import Firebase

struct TournamentSignUpView: View {
    let tournament: Tournament
    @State private var name = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Sign Up for \(tournament.name)")
                .font(.title)
                .padding()
            
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                    TextField("Phone Number", text: $phoneNumber)
                }
                
                Section {
                    Button("Sign Up") {
                        // Validate form data and create new player object
                        let player = Player(name: name, email: email, phoneNumber: phoneNumber)
                        
                        // Add new player to tournament
                        var updatedTournament = tournament
                        updatedTournament.addPlayer(player)
                        
                        // Save changes to tournament object in Firestore
                        let db = Firestore.firestore()
                        db.collection("tournaments").document(tournament.id!).setData(updatedTournament.toDict())
                        
                        // Dismiss the Sign Up view and navigate back to tournament detail screen
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(!formIsValid())
                }
            }
        }
    }
    
    private func formIsValid() -> Bool {
        // TODO: Validate form data (e.g. check that email and phone number are valid)
        return !name.isEmpty
    }
}

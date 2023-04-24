//
//  File.swift
//  TradeME
//
//  Created by Zhi Yong Huang on 4/23/23.
//

import SwiftUI
import FirebaseFirestore

struct TournamentCreationScreen: View {
    
    // properties to hold tournament details
    @State private var tournamentName = ""
    @State private var numberOfPlayers = ""
    @State private var entryFee = ""
    @State private var prizeMoney = ""
    @State private var tournamentStartDate = Date()
    @State private var tournamentStartTime = Date()
    
    // state to handle form validation and submission
    @State private var showValidationAlert = false
    @State private var validationErrorMessage = ""
    @State private var isSubmitting = false
    
    // reference to firestore
    private let db = Firestore.firestore()
    
    var body: some View {
        Form {
            Section(header: Text("Tournament Details")) {
                TextField("Tournament Name", text: $tournamentName)
                
                TextField("Number of Players", text: $numberOfPlayers)
                    .keyboardType(.numberPad)
                
                TextField("Entry Fee", text: $entryFee)
                    .keyboardType(.decimalPad)
                
                TextField("Prize Money", text: $prizeMoney)
                    .keyboardType(.decimalPad)
                
                DatePicker("Start Date", selection: $tournamentStartDate, displayedComponents: .date)
                
                DatePicker("Start Time", selection: $tournamentStartTime, displayedComponents: .hourAndMinute)
            }
            
            Section {
                Button(action: createTournament) {
                    if isSubmitting {
                        ProgressView()
                    } else {
                        Text("Create Tournament")
                    }
                }
                .disabled(isSubmitting)
            }
        }
        .navigationTitle("Create Tournament")
        .alert(isPresented: $showValidationAlert, content: {
            Alert(title: Text("Validation Error"), message: Text(validationErrorMessage), dismissButton: .default(Text("OK")))
        })
    }
    
    // function to create a new tournament
    private func createTournament() {
        // validate form fields
        guard !tournamentName.isEmpty, !numberOfPlayers.isEmpty, !entryFee.isEmpty, !prizeMoney.isEmpty else {
            validationErrorMessage = "Please fill out all fields"
            showValidationAlert = true
            return
        }
        
        guard let numPlayers = Int(numberOfPlayers), let fee = Double(entryFee), let prize = Double(prizeMoney) else {
            validationErrorMessage = "Please enter valid numbers for number of players, entry fee, and prize money"
            showValidationAlert = true
            return
        }
        
        // combine the start date and start time
        let combinedStartDateAndTime = combineDateAndTime(date: tournamentStartDate, time: tournamentStartTime)
        
        // create the tournament object
        let tournament = Tournament(name: tournamentName, rounds: [], numberOfPlayers: numPlayers, entryFee: fee, prizeMoney: prize, startDate: combinedStartDateAndTime ?? Date())
        
        // submit the tournament to firestore
        isSubmitting = true
        db.collection("tournaments").addDocument(data: tournament.toDict()) { error in
            if let error = error {
                print("Error adding tournament: \(error.localizedDescription)")
            } else {
                print("Tournament added successfully!")
            }
            isSubmitting = false
        }
    }
    
    // function to combine a date and time into a single date object
    func combineDateAndTime(date: Date, time: Date) -> Date? {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        
        return calendar.date(from: combinedComponents)
    }
}


struct TournamentCreationScreen_Previews: PreviewProvider {
    static var previews: some View {
        TournamentCreationScreen()
    }
}
